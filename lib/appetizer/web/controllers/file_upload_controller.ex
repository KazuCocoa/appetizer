defmodule Appetizer.Web.FileUploadController do
  use Appetizer.Web, :controller

  def upload_form(conn, _params) do
    render conn, "upload.html"
  end

  def upload(conn, %{"upload" => %{"file" => file}}) do
    file_extention = Path.extname file.filename

    file_uuid = UUID.uuid4 :hex

    s3_filename = "#{file_uuid}.#{file_extention}"
    IO.inspect s3_filename

    s3_bucket = "my-elixir-example"
    # We'll fill this in later

    {:ok, file_binary} = File.read(file.path)

    {:ok, result} = s3_bucket
                    |> ExAws.S3.put_object(s3_filename, file_binary)
                    |> ExAws.request()

    IO.inspect result

# "https://my-elixir-example.s3.amazonaws.com/my-elixir-example/9328beb79cf342b4b9d4355938192def..JPG"
# "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}"
# %{body: "",
#   headers: [{"x-amz-id-2",
#     "0k56VsvmVpCevEbZgCbuSF1tb0m/DHKscTUnJToH8GEMPBfPpBowxUNeei7sYuaBmHjienAlU8k="},
#    {"x-amz-request-id", "675D4907105DDA82"},
#    {"Date", "Tue, 25 Jul 2017 15:17:55 GMT"},
#    {"ETag", "\"0fc000ded82d1a7bedde12819138d781\""}, {"Content-Length", "0"},
#    {"Server", "AmazonS3"}], status_code: 200}

    conn
    |> put_flash(:success, "File uploaded successfully!")
    |> render("upload.html")

  end
end

