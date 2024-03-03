defmodule VidashLiveServerWeb.UploadController do
    use VidashLiveServerWeb, :controller

    def create_signed_url(conn, _params) do
      signed_url = generate_signed_url()
      json(conn, %{signed_url: signed_url})
    end

    defp generate_signed_url do
        bucket_name = "vidash-web-live-store"
        config = %{region: "eu-north-1"}
        query_params = [{"Content-Type", "image/*, application/pdf"}]
        # Generate a signed URL for PUT request with expiration time
        expiration_time = System.system_time(:second) + 360 # 6min

        presign_options = [
            virtual_host: false,
            query_params: query_params,
            expires: expiration_time,
        ]
        # Generate a unique image url name
        object_key = UUID.uuid4

        folder = case System.get_env("MIX_ENV") do
          "prod" ->
            # Code specific to production environment
            "prod"
          "dev" ->
            # Code specific to development environment
            "dev"
          _ ->
            # Code for other environments
            "files"
        end

        {:ok, signed_url} = ExAws.Config.new(:s3, config)
                |> ExAws.S3.presigned_url(:put, bucket_name, "#{folder}/#{object_key}", presign_options)

        signed_url
    end
  end
