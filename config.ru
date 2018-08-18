app = Proc.new do |env|
  req = Rack::Request.new(env)

  if req['url'] && req['origin']

    url = req['url']
    origin = req['origin']
    title = req['title']
    description = req['description']
    type = req['type']

    puts "URL: #{url}"

    response = """
                <!DOCTYPE html>
                <html>
                <head>
                  <title>#{title}</title>
                  <style type='text/css'>
                    img {
                      margin: 0 auto;
                      max-height: 100%;
                      max-width: 100%;
                    }
                  </style>
                  <meta property='og:title' content='#{title}'>
                  <meta property='og:type' content='#{type}'>
                  <meta property='og:image' content='#{url}'>
                  <meta property='og:url' content='#{url}'>
                  <meta property='og:description' content='#{url}'>
                </head>
                <body>
                  <h1>Redirecting...</h1>
                </body>
                  <script type='text/javascript'>
                      window.location='#{origin}'
                  </script>
                </html>
               """
  else
    response = "Usage... \n\nhttp://metamagic.mackaber.me/?url=http://example.com/some_image.png&title=some%20title&description=some%20description&type=some%20type"
  end

  [200, { 'Content-Type' => 'text/html' }, [response]]
end

run app