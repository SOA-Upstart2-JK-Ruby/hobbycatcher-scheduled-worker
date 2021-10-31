require 'roda'
require 'slim'

module InfoHunter
class App < Roda
plugin :render, engine: 'slim', views: 'app/views'
plugin :assets, css: 'style.css', path: 'app/views/assets'
plugin :halt
route do |routing|
routing.assets # load custom CSS
# GET /
routing.root do
view 'home',locals: { hobbies: ["read","bike","dance","sing"] }
end

  routing.on 'introhobby' do 
    routing.redirect "project/#{owner}/#{project}"
    puts routing.params.inspect
    view 'introhobby', locals: { hobbies: ["read","bike","dance","sing"]  }
    
  
    # routing.get "introhobby'", String do |type|
    #    puts "#{type.inspect} "
    #   end
    # routing.is do
    # POST /project/
    # routing.post do
    #     gh_url = routing.params['github_url'].downcase
    #     routing.halt 400 unless (gh_url.include? 'github.com') &&
    #     (gh_url.split('/').count >= 3)
    #     owner, project = gh_url.split('/')[-2..]
    # routing.redirect "project/#{owner}/#{project}"
    # end
    # end
    # routing.on String, String do |owner, project|
    #     # GET /project/owner/project
    #     routing.get do
    #     # github_project = Github::ProjectMapper
    #     # .new(GH_TOKEN)
    #     # .find(owner, project)
    #     view 'introhoppy', locals: { project: ["read","bike","dance","sing"]  }
    #     end
    # end
end
end
end

end

# # POST /project/
# routing.post do
#     gh_url = routing.params['github_url'].downcase
#     routing.halt 400 unless (gh_url.include? 'github.com') &&
#     (gh_url.split('/').count >= 3)
#     owner, project = gh_url.split('/')[-2..]
#     routing.redirect "project/#{owner}/#{project}"
#     end
#     end
# routing.on String, String do |owner, project|
# # GET /project/owner/project
# routing.get do
# github_project = Github::ProjectMapper
# .new(GH_TOKEN)
# .find(owner, project)
# view 'project', locals: { project: github_project }
# end

# module InfoHunter
#   class App < Roda
#     route do |r|
#       # GET / request
#       r.root do
#         r.redirect "/hello"
#       end

#       # /hello branch
#       r.on "hello" do
#         # Set variable for all routes in /hello branch
#         @greeting = 'Hello'

#         # GET /hello/world request
#         r.get "world" do
#           "#{@greeting} world!"
#         end

#         # /hello request
#         r.is do
#           # GET /hello request
#           r.get do
#             "#{@greeting}!"
#           end

#           # POST /hello request
#           r.post do
#             puts "Someone said #{@greeting}!"
#             r.redirect
#           end
#         end
#       end
#     end
#   end
# end