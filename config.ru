app = Proc.new do |env|
  req = Rack::Request.new(env)

  if req['url'] && req['orgn']

    url = req['url']
    orgn = req['orgn']
    title = req['title']
    description = req['description']
    type = req['type']

    card = req['card']
    site = req['site']
    creator = req['creator']

    puts "URL: #{url}"

    response = """
                <!DOCTYPE html>
                <html>
                <head>
                  <title>#{title}</title>
                  <style type='text/cssw'>
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
                  <meta property='og:description' content='#{description}'>
                  <meta property='og:image:width' content='1280'>
                  <meta property='og:image:height' content='501'>
                  <meta name='twitter:card' content='#{card}'>
                  <meta name='twitter:site' content='#{site}'>
                  <meta name='twitter:creator' content='#{creator}'>
                  <meta name='twitter:title' content='#{title}'>
                  <meta name='twitter:description' content='#{description}'>
                  <meta name='twitter:image' content='#{url}''>
                </head>
                <body>
                </body>
                  <script type='text/javascript'>
                    window.location='#{orgn}'
                  </script>
                </html>
               """
  else
    response = "Usage... \n\nhttp://metamagic.mackaber.me/?url=http://example.com/some_image.png&orgn=http://origin_website.com&title=some%20title&description=some%20description&type=some%20type"
  end

  [200, { 'Content-Type' => 'text/html' }, [response]]
end

run app
