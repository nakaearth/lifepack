# To change this template, choose Tools | Templates
# and open the template in the editor.

class MemoLogical < AbstractLogical
  def initialize
    
  end

  #Memoの登録
  def save_memo(memo,re_password)
    begin
      Memo.transaction do
        if memo.password != re_password
          logInfo("パスワードが違います")
          return nil
        end
        #unless checkInputword(memo.title+memo.message)
        #  logInfo("禁止文字です")
        #  return
        #end

        #パスワードの暗号化
        #old_pass = memo.password
        #memo.password = old_pass.crypt("memo");
        memo.save
        return memo
      end
    rescue Exception => e #大きな範囲で例外がある場合
      logError("メモ登録時に失敗しました。")
      logError("MemoID:"+memo.title+",Auth:"+memo.author)
      #例外処理
    end
  end
end
