module BigEarth 
  module Blockchain 
    module Blockchain
      def initialize 
      end
      
      def get_info
        system "bitcoin-cli getinfo"
      end
    end
  end
end
