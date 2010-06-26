class MoTopMenusController <  MoAbstractController
  before_filter :redirect_if_mobile
  trans_sid
   def index
    case request.mobile
    when Jpmobile::Mobile::Docomo
      p 'for DoCoMo'
    when Jpmobile::Mobile::Au
      p 'for au'
    when Jpmobile::Mobile::Softbank
      p 'for SoftBank'
    when Jpmobile::Mobile::Willcom
      p 'for Willcom'
    when Jpmobile::Mobile::Emobile
      p 'for EMOBILE'
    when Jpmobile::Mobile::Iphone
      p 'for Iphone'
    else
      # for PC
    end
  end
end
