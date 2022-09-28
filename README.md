# VideoStreamer

Back up your movies to the cloud, share them with friends (stream in the browser), add tags, comments, auto-load metadata, and so on.

## Storage

There are two supported methods of storage. Google Cloud Storage or local filesystem. Filesystem is the default (i.e. for self-hosting) but configuration for both setups is detailed below:

## Instructions

1. download the repo, run `bundle install`.
3. Create a Movie DB developer account and get the API key
3. copy `.env.example` to `.env` and fill in the required credentials:
  - **Movie DB**:
    - `MOVIE_DB_API_KEY`
  - **Uploading Files**:
    - `FILMS_DIR`: The local folder name where your movies are stored, e.g. /home/max/Movies. If you're serving files from GCS, this is only used in the sync/upload script. Otherwise, this is the location where files are actually served from.
  - **Authentication** - there are 2 accounts, admin and regular user. Dynamic account creation is not supported.
    - `ADMIN_NAME`
    - `ADMIN_PASSWORD`
    - `USER_NAME`
    - `USER_PASSWORD`
5. Run `rake db:create db:migrate` to set up the database.
6. Run `rake films:upload` to sync your local film collection with GCS (and create an index file)
7. Run `rails server` and open localhost:3000. Log in with the admin credentials you set up.
8. Click the "unsynced films" tab in the navbar and go through your films, importing each. Metadata can be auto-loaded from Movie DB. If there is no match, you can use "force upload" and then go to the "edit film" page (link at the bottom of the film page) and add the details there. 

### If you want to use GCS

2. create a GCS project and bucket. You do _not_ need to provide public access to the files (the Rails server will provide the clients with signed URLs). Download the credentials as JSON keyfile.
4. Add the following additional environment variables
  - `USE_GCS=true`
  - `GCS_PROJECT_ID`: The name of the GCS project
  - `GCS_BUCKET_NAME`
  - `GCS_CREDENTIALS`: The content of the credentials file (not the path)
 

## A note about formats.

Not all formats of video can be streamed in the browser.

Supported formats (with their associated `content-type`) are as follows:

```
{
  ".webm" => "video/webm",
  ".mp4" => "video/mp4",
  ".mpeg" => "video/mpeg",
  ".mpg" => "video/mpeg",
  ".ogg" => "video/ogg",
}
  ```

Similarly, regular `.srt` (and `.sub`) files cannot be used in the browser. Only `.vtt` is supported, as far as I'm aware.

Because of these restrictions, there is a `bin/convert_all` script which will do bulk conversion of video and subtitle files. Feel free to take a look, it's fairly simple and just uses `ffmpeg` under the hood.
