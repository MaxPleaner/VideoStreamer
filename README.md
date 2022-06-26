# VideoStreamer

Back up your movies to the cloud, share them with friends (stream in the browser), add tags, comments, auto-load metadata, and so on.

## Instructions

1. download the repo, run `bundle install`.
2. create a GCS project and bucket. You do _not_ need to provide public access to the files (the Rails server will provide the clients with signed URLs). Download the credentials as JSON keyfile.
3. Create a Movie DB developer account and get the API key
4. copy `.env.example` to `.env` and fill in the required credentials:
  - **GCS**:
    - `GCS_PROJECT_ID`: The name of the GCS project
    - `GCS_BUCKET_NAME`
    - `GCS_CREDENTIALS`: The content of the credentials file (not the path)
  - **Movie DB**:
    - `MOVIE_DB_API_KEY`
  - **Uploading Files**:
    - `FILMS_DIR`: The local folder name where your movies are stord, e.g. /home/max/Movies
  - **Authentication** - there are 2 accounts, admin and regular user. Dynamic account creation is not supported.
    - `ADMIN_NAME`
    - `ADMIN_PASSWORD`
    - `USER_NAME`
    - `USER_PASSWORD`
5. Run `rake db:create db:migrate` to set up the database.
6. Run `rake films:upload` to sync your local film collection with GCS (and create an index file)
