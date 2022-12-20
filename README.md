# imgbb

A small, self-contained script that uploads an image to imgbb.com

## Usage
You will need an imgbb account to create an API key. You can create an account [here](https://imgbb.com/signup) and API token [here](https://api.imgbb.com/).


```
$ export IMGBB_API_KEY=<insert-key-here>
$ imgbb ~/Screenshots/hello.jpg
$ Success: https://ibb.co/809fdsal
```
## Notes

- You can only upload 1 image at a time.
- File sizes are not checked pre-upload.