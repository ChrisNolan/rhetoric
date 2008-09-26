module BySite
  module ActMethods
    
    def by_site(options={})
      belongs_to :site
      
      before_validation :set_site
      
      extend ClassMethods
      include InstanceMethods
    end
    
    module ClassMethods
      
      def with_site
        with_scope :find => {:conditions => {:site_id => Site.current}} do
          yield
        end
      end
      
      def find_site(*args)
        with_site {find(*args)}
      end
      
    end
    
    module InstanceMethods
      
      def set_site
        self.site = Site.current unless site_id
      end
      
    end
  end
end
  