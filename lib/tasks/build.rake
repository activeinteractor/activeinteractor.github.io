# frozen_string_literal: true

namespace :build do
  task :activeinteractor do
    system 'bin/build-activeinteractor-api-docs'
  end

  desc 'Build all API docs'
  task api_docs: %i[activeinteractor]
end
