{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Exception
import           Control.Lens
import           Control.Monad                (void, when)
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Resource
import qualified Data.ByteString.Char8        as ByteString (pack)
import           Data.Conduit
import qualified Data.Conduit.List            as Conduit.List
import           Data.Default
import           Data.List.Utils
import           Data.Monoid
import           Data.Text                    (Text)
import qualified Data.Text                    as Text
import           Network
import           Network.HTTP.Conduit
import           System.Environment
import           Web.Authenticate.OAuth
import           Web.Twitter.Conduit
import           Web.Twitter.Types

track :: Text
track = Text.pack $ join "," [
    "big data", "wreq", "monads", "monadas", "monoid", "yesod" , "type-theory",
    "elm", "purescript", "hackage", "stackage", "cabal hell" , "haskellbr",
    "mapreduce", "haskell", "programação funcional", "scala", "clojure",
    "linguagem elixir", "erlang" ]

main :: IO ()
main = start `catch` \(SomeException e) -> do
    liftIO $ putStrLn ("[error] " ++ show e)
    start
  where
    start = withSocketsDo $ do
        mgr <- newManager tlsManagerSettings
        twInfo <- twitterInfoFromEnv
        runResourceT $ do
            haskellersStream <- stream twInfo mgr
                (statusesFilterByTrack track & language .~ Just "pt")
            liftIO $ putStrLn $ "[info] Started listening to tweets with"
            haskellersStream $$+- Conduit.List.mapM_ (handleEvent twInfo mgr)

handleEvent :: MonadResource m => TWInfo -> Manager -> StreamingAPI -> m ()
handleEvent twInfo mgr status = case status of
    SStatus s -> do
        liftIO $ putStrLn ("[tweet] " ++ show (statusText s))
        let username = Text.unpack (userScreenName (statusUser s))
        -- TODO should read the authenticated user's name
        when (username /= "haskellbr2") $ do
            liftIO $ putStrLn ("[follow] Following " ++ username)
            void (call twInfo mgr (friendshipsCreate (ScreenNameParam username)))
    _ -> return ()

twitterInfoFromEnv :: IO TWInfo
twitterInfoFromEnv = do
    key <- ByteString.pack <$> getEnv "TWITTER_API_KEY"
    secret <- ByteString.pack <$> getEnv "TWITTER_API_SECRET"
    oauthToken <- ByteString.pack <$> getEnv "TWITTER_OAUTH_TOKEN"
    oauthTokenSecret <- ByteString.pack <$> getEnv "TWITTER_OAUTH_TOKEN_SECRET"
    return $
        def { twToken =
                  def { twOAuth =
                            twitterOAuth { oauthConsumerKey = key
                                         , oauthConsumerSecret = secret
                                         }
                      , twCredential = Credential
                        [ ("oauth_token", oauthToken)
                        , ("oauth_token_secret", oauthTokenSecret)
                        ]
                      }
                     }
