# To change this template, choose Tools | Templates
# and open the template in the editor.

module Jpmobile
  module Mobile
    class Iphone < AbstractMobile
      USER_AGENT_REGEXP = /(iPhone)/
      def support_cookie?
        true
      end
    end
  end
end
