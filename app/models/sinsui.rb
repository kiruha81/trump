class Sinsui
  # コンストラクタ
  def initialize(card_data = nil)
    @opend = Array.new
    if card_data then
      data = card_data.split( ";" )
      @cards = data[0]
      @opend << data[1].to_i if data[1]
      @opend << data[2].to_i if data[2]
      return
    end
    # カード  表 / 裏 : +(表)、-(裏)
    #         マーク  : g(ハート)、h(ダイア)、i(クラブ)、j(スペード)、
    #                   k(ジョーカー)
    #         数字    : 16 進数 ( 1 ～ d )
    @cards = "-g1-g2-g3-g4-g5-g6-g7-g8-g9-ga-gb-gc-gd"
    @cards << "-h1-h2-h3-h4-h5-h6-h7-h8-h9-ha-hb-hc-hd"
    @cards << "-i1-i2-i3-i4-i5-i6-i7-i8-i9-ia-ib-ic-id"
    @cards << "-j1-j2-j3-j4-j5-j6-j7-j8-j9-ja-jb-jc-jd"
  end
  # カードの枚数を返す
  def size
    @cards.size / 3
  end
  def image(card_id)
    i = card_id * 3
    if "-" == @cards[i] then
      # 裏 ( 絵柄 )
      "cards/ura_red.png"
    else
      # 表 ( 数字 )
      "cards/"+@cards[i+1,2]+".png"
    end
  end
  # カードを開く
  def open(card_id)
    if 2 == @opend.size then
      @cards[@opend[0]] = "-"
      @cards[@opend[1]] = "-"
      @opend.clear
      return
    end
    i = card_id * 3
    if "-" == @cards[i] then
      @cards[i] = "+"
      @opend << i
      if 2 == @opend.size then
        if @cards[@opend[0]+2] == @cards[i+2] then
          @opend.clear
        end
      end
    end
  end
  # session へ保存するためのデータを返す
  def get
    @cards +
    ( @opend[0] ? ( ";" + @opend[0].to_s ) : "" ) +
    ( @opend[1] ? ( ";" + @opend[1].to_s ) : "" )
  end
end