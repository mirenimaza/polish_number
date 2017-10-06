# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), "spec_helper")

describe :PolishNumber do
  {
    0 => { :number => 'zero', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1 => { :number => 'jeden', :PLN => 'złoty', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    2 => { :number => 'dwa', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    4 => { :number => 'cztery', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    5 => { :number => 'pięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    9 => { :number => 'dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    10 => { :number => 'dziesięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    11 => { :number => 'jedenaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    12 => { :number => 'dwanaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    14 => { :number => 'czternaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    15 => { :number => 'piętnaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    19 => { :number => 'dziewiętnaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    20 => { :number => 'dwadzieścia', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    21 => { :number => 'dwadzieścia jeden', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    22 => { :number => 'dwadzieścia dwa', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    24 => { :number => 'dwadzieścia cztery', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    25 => { :number => 'dwadzieścia pięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    29 => { :number => 'dwadzieścia dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    30 => { :number => 'trzydzieści', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    31 => { :number => 'trzydzieści jeden', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    32 => { :number => 'trzydzieści dwa', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    32.21 => { :number => 'trzydzieści dwa', :PLN => 'złote', :cents_digital => '21/100', :cents_word => 'dwadzieścia jeden', :NO_100 => 'setnych', :PLN_100 => 'groszy' },
    34 => { :number => 'trzydzieści cztery', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    35 => { :number => 'trzydzieści pięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    45 => { :number => 'czterdzieści pięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    99 => { :number => 'dziewięćdziesiąt dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    100 => { :number => 'sto', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    100.99 => { :number => 'sto', :PLN => 'złotych', :cents_digital => '99/100', :cents_word => 'dziewięćdziesiąt dziewięć', :NO_100 => 'setnych', :PLN_100 => 'groszy' },
    101 => { :number => 'sto jeden', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    200 => { :number => 'dwieście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    212 => { :number => 'dwieście dwanaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    323 => { :number => 'trzysta dwadzieścia trzy', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    440 => { :number => 'czterysta czterdzieści', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    999 => { :number => 'dziewięćset dziewięćdziesiąt dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1000 => { :number => 'tysiąc', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1002 => { :number => 'tysiąc dwa', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1011 => { :number => 'tysiąc jedenaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1111 => { :number => 'tysiąc sto jedenaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1222 => { :number => 'tysiąc dwieście dwadzieścia dwa', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    2415 => { :number => 'dwa tysiące czterysta piętnaście', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    5000 => { :number => 'pięć tysięcy', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    10000 => { :number => 'dziesięć tysięcy', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    22141 => { :number => 'dwadzieścia dwa tysiące sto czterdzieści jeden', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    123754 => { :number => 'sto dwadzieścia trzy tysiące siedemset pięćdziesiąt cztery', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    999999 => { :number => 'dziewięćset dziewięćdziesiąt dziewięć tysięcy dziewięćset dziewięćdziesiąt dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    1999999 => { :number => 'milion dziewięćset dziewięćdziesiąt dziewięć tysięcy dziewięćset dziewięćdziesiąt dziewięć', :PLN => 'złotych', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' },
    5123754 => { :number => 'pięć milionów sto dwadzieścia trzy tysiące siedemset pięćdziesiąt cztery', :PLN => 'złote', :cents_digital => '00/100', :cents_word => 'zero', :PLN_100 => 'groszy' }
    }.each do |number, translation|
    it "should translate #{number} to '#{translation[:number]}'" do
      if number == number.to_i
        result = translation[:number]
      else
        result = "#{translation[:number]} i #{translation[:cents_word]} #{translation[:NO_100]}"
      end
      PolishNumber.translate(number).should == result
    end

    it "should translate #{number} to '#{translation[:number]} #{translation[:PLN]}' with currency :PLN" do
      #for auto hundredth part is omited
      if number == number.to_i
        result = "#{translation[:number]} #{translation[:PLN]}"
      else
        result = "#{translation[:number]} #{translation[:PLN]}, #{translation[:cents_word]} #{translation[:PLN_100]}"
      end
      PolishNumber.translate(number, :currency => :PLN).should == result
    end

    it "should translate #{number} to '#{translation[:number]} #{translation[:PLN]} #{translation[:cents_digital]}' with currency :PLN and :cents => :digits" do
      PolishNumber.translate(number, :currency => :PLN, :cents => :digits).should == "#{translation[:number]} #{translation[:PLN]} #{translation[:cents_digital]}"
    end
    it "should translate #{number} to '#{translation[:number]} #{translation[:PLN]}' with currency :PLN and :cents => :no" do
      PolishNumber.translate(number, :currency => :PLN, :cents => :no).should ==
          "#{translation[:number]} #{translation[:PLN]}"
    end

    it "should translate #{number} to '#{translation[:number]} #{translation[:PLN]}' with currency :PLN and :cents => :words" do
      PolishNumber.translate(number, :currency => :PLN, :cents => :words).should ==
          "#{translation[:number]} #{translation[:PLN]}, #{translation[:cents_word]} #{translation[:PLN_100]}"
    end

  end
  it "should translate 0.50 to pięćdziesiąt setnych" do
    PolishNumber.translate(0.50).should ==
        "pięćdziesiąt setnych"
  end

  it "should translate 0.50 to pięćdziesiąt setnych with currency :PLN and :cents => :words" do
    PolishNumber.translate(0.50, :currency => :PLN, :cents => :words).should ==
        "zero złotych, pięćdziesiąt groszy"
  end

  it "should translate 0.50 to pięćdziesiąt setnych with currency :PLN and :cents => :digits" do
    PolishNumber.translate(0.50, :currency => :PLN, :cents => :digits).should ==
        "zero złotych 50/100"
  end

  it "should translate 1 :with currrency :EUR to jedno euro" do
    PolishNumber.translate(1, :currency => :EUR).should ==
        "jedno euro"
  end

  it "should translate 21 :with currrency :EUR to dwadzieścia jeden euro" do
    PolishNumber.translate(21, :currency => :EUR).should ==
        "dwadzieścia jeden euro"
  end

  it "should translate 0.01 :with currrency :SEK to jedno öre" do
    PolishNumber.translate(0.01, :currency => :SEK).should ==
        "jedno öre"
  end

  it "should translate 2 :with currrency :SEK to dwie korony" do
    PolishNumber.translate(2, :currency => :SEK).should ==
        "dwie korony"
  end

  it "should translate 21 :with currrency :SEK to dwadzieścia jeden koron" do
    PolishNumber.translate(21, :currency => :SEK).should ==
        "dwadzieścia jeden koron"
  end

  it "should translate 52 :with currrency :SEK to pięćdziesiąt dwie korony" do
    PolishNumber.translate(52, :currency => :SEK).should ==
        "pięćdziesiąt dwie korony"
  end

  it "should translate 1_000_002 :with currrency :SEK to milion dwie korony" do
    PolishNumber.translate(1_000_002, :currency => :SEK).should ==
        "milion dwie korony"
  end
  it "should translate 1_000_001 to milion jeden" do
    PolishNumber.translate(1_000_001).should ==
        "milion jeden"
  end

  it "should raise ArgumentError when number is smaller than 0" do
    lambda { PolishNumber.translate(-1) }.should.raise(ArgumentError)
  end

  it "should raise ArgumentError when number is greater than 999999999.99" do
    lambda { PolishNumber.translate(1_000_000_000) }.should.raise(ArgumentError)
  end

  it "should raise ArgumentError when currency is unknown" do
    lambda { PolishNumber.translate(1_000_000, :currency => :ABC) }.
      should.raise(ArgumentError)
  end

  it "should accept new currencies" do
    PolishNumber.add_currency(:COWS, { :one => 'krowa', :few => 'krowy', :many => 'krów', :gender => :she,
      :one_100 => 'ser', :few_100 => 'sery', :many_100 => 'serów', :gender_100 => :hi})
    PolishNumber.translate(35.05, :currency => :COWS).should ==
      "trzydzieści pięć krów, pięć serów"
  end

  #ORDINAL NUMBERS
   {
       0 => { :masculine => 'zerowy', :feminine => 'zerowa', :neuter => 'zerowe'},
       1 => { :masculine => 'pierwszy', :feminine => 'pierwsza', :neuter => 'pierwsze'},
       2 => { :masculine => 'drugi', :feminine => 'druga', :neuter => 'drugie'},
       3 => { :masculine => 'trzeci', :feminine => 'trzecia', :neuter => 'trzecie'},
       6 => { :masculine => 'szósty', :feminine => 'szósta', :neuter => 'szóste'},
       7 => { :masculine => 'siódmy', :feminine => 'siódma', :neuter => 'siódme'},
       10 => { :masculine => 'dziesiąty', :feminine => 'dziesiąta', :neuter => 'dziesiąte'},
       11 => { :masculine => 'jedenasty', :feminine => 'jedenasta', :neuter => 'jedenaste'},
       12 => { :masculine => 'dwunasty', :feminine => 'dwunasta', :neuter => 'dwunaste'},
       14 => { :masculine => 'czternasty', :feminine => 'czternasta', :neuter => 'czternaste'},
       17 => { :masculine => 'siedemnasty', :feminine => 'siedemnasta', :neuter => 'siedemnaste'},
       19 => { :masculine => 'dziewiętnasty', :feminine => 'dziewiętnasta', :neuter => 'dziewiętnaste'},
       20 => { :masculine => 'dwudziesty', :feminine => 'dwudziesta', :neuter => 'dwudzieste'},
       30 => { :masculine => 'trzydziesty', :feminine => 'trzydziesta', :neuter => 'trzydzieste'},
       31 => { :masculine => 'trzydziesty pierwszy', :feminine => 'trzydziesta pierwsza', :neuter => 'trzydzieste pierwsze'},
       34 => { :masculine => 'trzydziesty czwarty', :feminine => 'trzydziesta czwarta', :neuter => 'trzydzieste czwarte'},
       38 => { :masculine => 'trzydziesty ósmy', :feminine => 'trzydziesta ósma', :neuter => 'trzydzieste ósme'},
       45 => { :masculine => 'czterdziesty piąty', :feminine => 'czterdziesta piąta', :neuter => 'czterdzieste piąte'},
       99 => { :masculine => 'dziewięćdziesiąty dziewiąty', :feminine => 'dziewięćdziesiąta dziewiąta', :neuter => 'dziewięćdziesiąte dziewiąte'}
   }.each do |number, translation|
     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :nominative, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :nominative, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:neuter]}'" do
       result = translation[:neuter]
       PolishNumber.translate_ordinal(number, :grammatical_case => :nominative, :gender => :neuter).should == result
     end

   end

   {
       0 => { :masculine => 'zerowego', :feminine => 'zerowej', :non_masculine => 'zerowych'},
       1 => { :masculine => 'pierwszego', :feminine => 'pierwszej', :non_masculine => 'pierwszych'},
       2 => { :masculine => 'drugiego', :feminine => 'drugiej', :non_masculine => 'drugich'},
       3 => { :masculine => 'trzeciego', :feminine => 'trzeciej', :non_masculine => 'trzecich'},
       6 => { :masculine => 'szóstego', :feminine => 'szóstej', :non_masculine => 'szóstych'},
       7 => { :masculine => 'siódmego', :feminine => 'siódmej', :non_masculine => 'siódmych'},
       10 => { :masculine => 'dziesiątego', :feminine => 'dziesiątej', :non_masculine => 'dziesiątych'},
       11 => { :masculine => 'jedenastego', :feminine => 'jedenastej', :non_masculine => 'jedenastych'},
       12 => { :masculine => 'dwunastego', :feminine => 'dwunastej', :non_masculine => 'dwunastych'},
       14 => { :masculine => 'czternastego', :feminine => 'czternastej', :non_masculine => 'czternastych'},
       17 => { :masculine => 'siedemnastego', :feminine => 'siedemnastej', :non_masculine => 'siedemnastych'},
       19 => { :masculine => 'dziewiętnastego', :feminine => 'dziewiętnastej', :non_masculine => 'dziewiętnastych'},
       20 => { :masculine => 'dwudziestego', :feminine => 'dwudziestej', :non_masculine => 'dwudziestych'},
       30 => { :masculine => 'trzydziestego', :feminine => 'trzydziestej', :non_masculine => 'trzydziestych'},
       31 => { :masculine => 'trzydziestego pierwszego', :feminine => 'trzydziestej pierwszej', :non_masculine => 'trzydziestych pierwszych'},
       34 => { :masculine => 'trzydziestego czwartego', :feminine => 'trzydziestej czwartej', :non_masculine => 'trzydziestych czwartych'},
       38 => { :masculine => 'trzydziestego ósmego', :feminine => 'trzydziestej ósmej', :non_masculine => 'trzydziestych ósmych'},
       45 => { :masculine => 'czterdziestego piątego', :feminine => 'czterdziestej piątej', :non_masculine => 'czterdziestych piątych'},
       99 => { :masculine => 'dziewięćdziesiątego dziewiątego', :feminine => 'dziewięćdziesiątej dziewiątej', :non_masculine => 'dziewięćdziesiątych dziewiątych'}
   }.each do |number, translation|
     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :genitive, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :genitive, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:non_masculine]}'" do
       result = translation[:non_masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :genitive, :gender => :non_masculine).should == result
     end

   end

   {
       0 => { :masculine => 'zerowemu', :feminine => 'zerowej', :non_masculine => 'zerowym'},
       1 => { :masculine => 'pierwszemu', :feminine => 'pierwszej', :non_masculine => 'pierwszym'},
       2 => { :masculine => 'drugiemu', :feminine => 'drugiej', :non_masculine => 'drugim'},
       3 => { :masculine => 'trzeciemu', :feminine => 'trzeciej', :non_masculine => 'trzecim'},
       6 => { :masculine => 'szóstemu', :feminine => 'szóstej', :non_masculine => 'szóstym'},
       7 => { :masculine => 'siódmemu', :feminine => 'siódmej', :non_masculine => 'siódmym'},
       10 => { :masculine => 'dziesiątemu', :feminine => 'dziesiątej', :non_masculine => 'dziesiątym'},
       11 => { :masculine => 'jedenastemu', :feminine => 'jedenastej', :non_masculine => 'jedenastym'},
       12 => { :masculine => 'dwunastemu', :feminine => 'dwunastej', :non_masculine => 'dwunastym'},
       14 => { :masculine => 'czternastemu', :feminine => 'czternastej', :non_masculine => 'czternastym'},
       17 => { :masculine => 'siedemnastemu', :feminine => 'siedemnastej', :non_masculine => 'siedemnastym'},
       19 => { :masculine => 'dziewiętnastemu', :feminine => 'dziewiętnastej', :non_masculine => 'dziewiętnastym'},
       20 => { :masculine => 'dwudziestemu', :feminine => 'dwudziestej', :non_masculine => 'dwudziestym'},
       30 => { :masculine => 'trzydziestemu', :feminine => 'trzydziestej', :non_masculine => 'trzydziestym'},
       31 => { :masculine => 'trzydziestemu pierwszemu', :feminine => 'trzydziestej pierwszej', :non_masculine => 'trzydziestym pierwszym'},
       34 => { :masculine => 'trzydziestemu czwartemu', :feminine => 'trzydziestej czwartej', :non_masculine => 'trzydziestym czwartym'},
       38 => { :masculine => 'trzydziestemu ósmemu', :feminine => 'trzydziestej ósmej', :non_masculine => 'trzydziestym ósmym'},
       45 => { :masculine => 'czterdziestemu piątemu', :feminine => 'czterdziestej piątej', :non_masculine => 'czterdziestym piątym'},
       99 => { :masculine => 'dziewięćdziesiątemu dziewiątemu', :feminine => 'dziewięćdziesiątej dziewiątej', :non_masculine => 'dziewięćdziesiątym dziewiątym'}
   }.each do |number, translation|
     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :dative, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :dative, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:non_masculine]}'" do
       result = translation[:non_masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :dative, :gender => :non_masculine).should == result
     end

   end

   {
       0 => { :masculine => 'zerowego', :feminine => 'zerową', :neuter => 'zerowe', :masculine_personal => 'zerowych'},
       1 => { :masculine => 'pierwszego', :feminine => 'pierwszą', :neuter => 'pierwsze', :masculine_personal => 'pierwszych'},
       2 => { :masculine => 'drugiego', :feminine => 'drugą', :neuter => 'drugie', :masculine_personal => 'drugich'},
       3 => { :masculine => 'trzeciego', :feminine => 'trzecią', :neuter => 'trzecie', :masculine_personal => 'trzecich'},
       6 => { :masculine => 'szóstego', :feminine => 'szóstą', :neuter => 'szóste', :masculine_personal => 'szóstych'},
       7 => { :masculine => 'siódmego', :feminine => 'siódmą', :neuter => 'siódme', :masculine_personal => 'siódmych'},
       10 => { :masculine => 'dziesiątego', :feminine => 'dziesiątą', :neuter => 'dziesiąte', :masculine_personal => 'dziesiątych'},
       11 => { :masculine => 'jedenastego', :feminine => 'jedenastą', :neuter => 'jedenaste', :masculine_personal => 'jedenastych'},
       12 => { :masculine => 'dwunastego', :feminine => 'dwunastą', :neuter => 'dwunaste', :masculine_personal => 'dwunastych'},
       14 => { :masculine => 'czternastego', :feminine => 'czternastą', :neuter => 'czternaste', :masculine_personal => 'czternastych'},
       17 => { :masculine => 'siedemnastego', :feminine => 'siedemnastą', :neuter => 'siedemnaste', :masculine_personal => 'siedemnastych'},
       19 => { :masculine => 'dziewiętnastego', :feminine => 'dziewiętnastą', :neuter => 'dziewiętnaste', :masculine_personal => 'dziewiętnastych'},
       20 => { :masculine => 'dwudziestego', :feminine => 'dwudziestą', :neuter => 'dwudzieste', :masculine_personal => 'dwudziestych'},
       30 => { :masculine => 'trzydziestego', :feminine => 'trzydziestą', :neuter => 'trzydzieste', :masculine_personal => 'trzydziestych'},
       31 => { :masculine => 'trzydziestego pierwszego', :feminine => 'trzydziestą pierwszą', :neuter => 'trzydzieste pierwsze', :masculine_personal => 'trzydziestych pierwszych'},
       34 => { :masculine => 'trzydziestego czwartego', :feminine => 'trzydziestą czwartą', :neuter => 'trzydzieste czwarte', :masculine_personal => 'trzydziestych czwartych'},
       38 => { :masculine => 'trzydziestego ósmego', :feminine => 'trzydziestą ósmą', :neuter => 'trzydzieste ósme', :masculine_personal => 'trzydziestych ósmych'},
       45 => { :masculine => 'czterdziestego piątego', :feminine => 'czterdziestą piątą', :neuter => 'czterdzieste piąte', :masculine_personal => 'czterdziestych piątych'},
       99 => { :masculine => 'dziewięćdziesiątego dziewiątego', :feminine => 'dziewięćdziesiątą dziewiątą', :neuter => 'dziewięćdziesiąte dziewiąte', :masculine_personal => 'dziewięćdziesiątych dziewiątych'}
   }.each do |number, translation|
     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :accusative, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :accusative, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:neuter]}'" do
       result = translation[:neuter]
       PolishNumber.translate_ordinal(number, :grammatical_case => :accusative, :gender => :neuter).should == result
     end
     it "should translate #{number} to '#{translation[:masculine_personal]}'" do
       result = translation[:masculine_personal]
       PolishNumber.translate_ordinal(number, :grammatical_case => :accusative, :gender => :masculine_personal).should == result
     end

   end

   {
       0 => { :masculine => 'zerowym', :feminine => 'zerową', :non_masculine => 'zerowymi'},
       1 => { :masculine => 'pierwszym', :feminine => 'pierwszą', :non_masculine => 'pierwszymi'},
       2 => { :masculine => 'drugim', :feminine => 'drugą', :non_masculine => 'drugimi'},
       3 => { :masculine => 'trzecim', :feminine => 'trzecią', :non_masculine => 'trzecimi'},
       6 => { :masculine => 'szóstym', :feminine => 'szóstą', :non_masculine => 'szóstymi'},
       7 => { :masculine => 'siódmym', :feminine => 'siódmą', :non_masculine => 'siódmymi'},
       10 => { :masculine => 'dziesiątym', :feminine => 'dziesiątą', :non_masculine => 'dziesiątymi'},
       11 => { :masculine => 'jedenastym', :feminine => 'jedenastą', :non_masculine => 'jedenastymi'},
       12 => { :masculine => 'dwunastym', :feminine => 'dwunastą', :non_masculine => 'dwunastymi'},
       14 => { :masculine => 'czternastym', :feminine => 'czternastą', :non_masculine => 'czternastymi'},
       17 => { :masculine => 'siedemnastym', :feminine => 'siedemnastą', :non_masculine => 'siedemnastymi'},
       19 => { :masculine => 'dziewiętnastym', :feminine => 'dziewiętnastą', :non_masculine => 'dziewiętnastymi'},
       20 => { :masculine => 'dwudziestym', :feminine => 'dwudziestą', :non_masculine => 'dwudziestymi'},
       30 => { :masculine => 'trzydziestym', :feminine => 'trzydziestą', :non_masculine => 'trzydziestymi'},
       31 => { :masculine => 'trzydziestym pierwszym', :feminine => 'trzydziestą pierwszą', :non_masculine => 'trzydziestymi pierwszymi'},
       34 => { :masculine => 'trzydziestym czwartym', :feminine => 'trzydziestą czwartą', :non_masculine => 'trzydziestymi czwartymi'},
       38 => { :masculine => 'trzydziestym ósmym', :feminine => 'trzydziestą ósmą', :non_masculine => 'trzydziestymi ósmymi'},
       45 => { :masculine => 'czterdziestym piątym', :feminine => 'czterdziestą piątą', :non_masculine => 'czterdziestymi piątymi'},
       99 => { :masculine => 'dziewięćdziesiątym dziewiątym', :feminine => 'dziewięćdziesiątą dziewiątą', :non_masculine => 'dziewięćdziesiątymi dziewiątymi'}
   }.each do |number, translation|
     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :instrumental, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :instrumental, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:non_masculine]}'" do
       result = translation[:non_masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :instrumental, :gender => :non_masculine).should == result
     end

   end

   {
       0 => { :masculine => 'zerowym', :feminine => 'zerowej', :non_masculine => 'zerowych'},
       1 => { :masculine => 'pierwszym', :feminine => 'pierwszej', :non_masculine => 'pierwszych'},
       2 => { :masculine => 'drugim', :feminine => 'drugiej', :non_masculine => 'drugich'},
       3 => { :masculine => 'trzecim', :feminine => 'trzeciej', :non_masculine => 'trzecich'},
       6 => { :masculine => 'szóstym', :feminine => 'szóstej', :non_masculine => 'szóstych'},
       7 => { :masculine => 'siódmym', :feminine => 'siódmej', :non_masculine => 'siódmych'},
       10 => { :masculine => 'dziesiątym', :feminine => 'dziesiątej', :non_masculine => 'dziesiątych'},
       11 => { :masculine => 'jedenastym', :feminine => 'jedenastej', :non_masculine => 'jedenastych'},
       12 => { :masculine => 'dwunastym', :feminine => 'dwunastej', :non_masculine => 'dwunastych'},
       14 => { :masculine => 'czternastym', :feminine => 'czternastej', :non_masculine => 'czternastych'},
       17 => { :masculine => 'siedemnastym', :feminine => 'siedemnastej', :non_masculine => 'siedemnastych'},
       19 => { :masculine => 'dziewiętnastym', :feminine => 'dziewiętnastej', :non_masculine => 'dziewiętnastych'},
       20 => { :masculine => 'dwudziestym', :feminine => 'dwudziestej', :non_masculine => 'dwudziestych'},
       30 => { :masculine => 'trzydziestym', :feminine => 'trzydziestej', :non_masculine => 'trzydziestych'},
       31 => { :masculine => 'trzydziestym pierwszym', :feminine => 'trzydziestej pierwszej', :non_masculine => 'trzydziestych pierwszych'},
       34 => { :masculine => 'trzydziestym czwartym', :feminine => 'trzydziestej czwartej', :non_masculine => 'trzydziestych czwartych'},
       38 => { :masculine => 'trzydziestym ósmym', :feminine => 'trzydziestej ósmej', :non_masculine => 'trzydziestych ósmych'},
       45 => { :masculine => 'czterdziestym piątym', :feminine => 'czterdziestej piątej', :non_masculine => 'czterdziestych piątych'},
       99 => { :masculine => 'dziewięćdziesiątym dziewiątym', :feminine => 'dziewięćdziesiątej dziewiątej', :non_masculine => 'dziewięćdziesiątych dziewiątych'}
   }.each do |number, translation|

     it "should translate #{number} to '#{translation[:masculine]}'" do
       result = translation[:masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :locative, :gender => :masculine).should == result
     end
     it "should translate #{number} to '#{translation[:feminine]}'" do
       result = translation[:feminine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :locative, :gender => :feminine).should == result
     end
     it "should translate #{number} to '#{translation[:non_masculine]}'" do
       result = translation[:non_masculine]
       PolishNumber.translate_ordinal(number, :grammatical_case => :locative, :gender => :non_masculine).should == result
     end
   end

   it "should raise ArgumentError when number is smaller than 0" do
     lambda { PolishNumber.translate_ordinal(-1) }.should.raise(ArgumentError)
   end

   it "should raise ArgumentError when number is greater than 99" do
     lambda { PolishNumber.translate_ordinal(100) }.should.raise(ArgumentError)
   end

   it "should raise ArgumentError when gender is masculine_personal, case is nominative and number is greater than 4" do
     lambda { PolishNumber.translate_ordinal(5, :gender => :masculine_personal, :grammatical_case => :nominative) }.should.raise(ArgumentError)
   end


end
