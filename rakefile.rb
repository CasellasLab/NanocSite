#Rakefile
#require 'nanoc3/tasks'

require 'rubygems'

desc "Publish site to Github"
task :publish do
 src = 'output/'
 dst = 'casellaslab.git.io/'

 puts '=== Copy .woff font file (for IE8) into output directory...'
sh("cp /Users/mathee/Documents/CasellasWeb/glyphicons-halflings-regular.woff output/assets/fonts/")

 puts '==== Syncing working directory...'
 sh("rsync -arv --delete --exclude '.git' #{src} #{dst}")
 
 puts '==== Commiting changed files'
 sh("cd #{dst}; git init; git add *")
 
 commit_message = "Update website: " #+ issue.updated_at.to_datetime.rfc3339   #(string)Time.now
 sh("cd #{dst}; git commit -m '#{commit_message}'")

 puts "Adding remote locations Casellaslab/casellaslab.github.io"
 sh("cd #{dst};git remote; git remote add origin https://github.com/CasellasLab/CasellasLab.github.io")

 puts '==== Pushing changes to Github'
 sh("cd #{dst}; git push --force origin master")

 puts '==== Published website to Github'

end
