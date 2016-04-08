module BigEarth 
  module Blockchain 
    class Blockchain
      def initialize 
      end
      
      def get_info
        `bitcoin-cli getinfo`
      end
    end
  end
end
