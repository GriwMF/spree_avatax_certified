module SpreeAvatax
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'app/assets/javascripts/spree/frontend/frontend.js', "//= require spree/frontend/spree_avatax\n"
        append_file 'app/assets/javascripts/spree/backend/backend.js', "//= require spree/backend/spree_avatax\n"
      end

      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_avatax\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_avatax\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_avatax'
      end

      def run_migrations
        res = ask 'Would you like to run the migrations now? [Y/n]'
        if res == '' || res.downcase == 'y'
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
