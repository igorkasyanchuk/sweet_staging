module SweetStaging
  class Engine < ::Rails::Engine
    isolate_namespace SweetStaging

    if SweetStaging.try(:enabled) # for rails c
    end

  end
end