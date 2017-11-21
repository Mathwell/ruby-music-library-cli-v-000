module Concerns::Findable
    def find_by_name(name)
      all.detect{ |a| a.name == name }
    end

    def find_or_create_by_name(name)
      #finding=find_by_name(name)
      #return finding  unless finding==NilClass
      #create(name)
      find_by_name(name) || create(name)
    end

end
