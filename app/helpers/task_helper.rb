module TaskHelper
  def status_name(val)
    if ("todo"==val)
      return "未着手"
    elsif ("doing"==val)
      return "今やってる"
    elsif ("done"==val)
      return "完了！"
    else
      return "";
    end
  end

  def priority_name(val)
    if (1==val)
      return "後でやる"
    elsif (2==val)
      return "後少ししたら"
    elsif (3==val)
      return "今すぐやる"
    else
      return "";
    end
  end

  def list_color_num(val)
    if(val%2 ==0)
      return 0
    else
      return 1
    end
  end

end
