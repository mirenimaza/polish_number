# encoding: utf-8

require "polish_number/version"

module PolishNumber
  HUNDREDS = ['', 'sto ', 'dwieście ', 'trzysta ', 'czterysta ', 'pięćset ', 'sześćset ',
              'siedemset ', 'osiemset ', 'dziewięćset ']

  TENS = ['', 'dziesięć ', 'dwadzieścia ', 'trzydzieści ', 'czterdzieści ', 'pięćdziesiąt ',
          'sześćdziesiąt ', 'siedemdziesiąt ', 'osiemdziesiąt ', 'dziewięćdziesiąt ']

  TEENS = ['', 'jedenaście ', 'dwanaście ', 'trzynaście ', 'czternaście ', 'piętnaście ',
           'szesnaście ', 'siedemnaście ', 'osiemnaście ', 'dziewiętnaście ']

  UNITIES = ['', 'jeden ', 'dwa ', 'trzy ', 'cztery ', 'pięć ', 'sześć ', 'siedem ', 'osiem ',
             'dziewięć ']

  ZERO = 'zero'

  THOUSANDS = {:one => 'tysiąc', :few => 'tysiące', :many => 'tysięcy'}

  MILLIONS = {:one => 'milion', :few => 'miliony', :many => 'milionów'}


  HUNDREDS_ORDINALS = ['', 'setny ', 'dwusetny ', 'trzysetny ', 'czterysetny ', 'pięćsetny ', 'sześćsetny ',
                       'siedemsetny ', 'osiemsetny ', 'dziewięćsetny ']

  TENS_ORDINALS = ['', 'dziesiąty ', 'dwudziesty ', 'trzydziesty ', 'czterdziesty ', 'pięćdziesiąty ',
                   'sześćdziesiąty ', 'siedemdziesiąty ', 'osiemdziesiąty ', 'dziewięćdziesiąty ']

  TEENS_ORDINALS = ['', 'jedenasty ', 'dwunasty ', 'trzynasty ', 'czternasty ', 'piętnasty ',
                    'szesnasty ', 'siedemnasty ', 'osiemnasty ', 'dziewiętnasty ']

  UNITIES_ORDINALS = ['', 'pierwszy ', 'drugi ', 'trzeci ', 'czwarty ', 'piąty ', 'szósty ', 'siódmy ', 'ósmy ',
                      'dziewiąty ']

  ZERO_ORDINALS = 'zerowy'

  TYPES = [:cardinal, :ordinal]

  GENDERS = [:masculine, :feminine, :neuter, :masculine_personal, :non_masculine]

  CASES = [:nominative, :genitive, :dative, :accusative, :instrumental, :locative, :vocative]


  CENTS = [:auto, :no, :words, :digits]

  CURRENCIES = {
      :NO => {:one => '', :few => '', :many => '',
              :one_100 => 'setna', :few_100 => 'setne', :many_100 => 'setnych', :gender_100 => :she},
      :PLN => {:one => 'złoty', :few => 'złote', :many => 'złotych',
               :one_100 => 'grosz', :few_100 => 'grosze', :many_100 => 'groszy'},
      :USD => { :one => 'dolar', :few => 'dolary', :many => 'dolarów',
                :one_100 => 'cent', :few_100 => 'centy', :many_100 => 'centów'},
      :EUR => { :one => 'euro', :few => 'euro', :many => 'euro', :gender => :it,
                :one_100 => 'cent', :few_100 => 'centy', :many_100 => 'centów'},
      :GBP => { :one => 'funt', :few => 'funty', :many => 'funtów',
                :one_100 => 'pens', :few_100 => 'pensy', :many_100 => 'pensów'},
      :CHF => { :one => 'frank', :few => 'franki', :many => 'franków',
                :one_100 => 'centym', :few_100 => 'centymy', :many_100 => 'centymów'},
      :SEK => { :one => 'korona', :few => 'korony', :many => 'koron', :gender => :she,
                :one_100 => 'öre', :few_100 => 'öre', :many_100 => 'öre', :gender_100 => :it}
  }

  def self.validate(number, options)
    if options[:currency] && !CURRENCIES.has_key?(options[:currency])
      raise ArgumentError, "Unknown :currency option '#{options[:currency].inspect}'." +
          " Choose one from: #{CURRENCIES.inspect}"
    end

    if options[:cents] && !CENTS.include?(options[:cents])
      raise ArgumentError, "Unknown :cents option '#{options[:cents].inspect}'." +
          " Choose one from: #{CENTS.inspect}"
    end

    if options[:type] && !TYPES.include?(options[:type])
      raise ArgumentError, "Unknown :type option '#{options[:type].inspect}'." +
          " Choose one from: #{TYPES.inspect}"
    end

    if options[:gender] && !GENDERS.include?(options[:gender])
      raise ArgumentError, "Unknown :gender option '#{options[:gender].inspect}'." +
          " Choose one from: #{GENDERS.inspect}"
    end

    if options[:case] && !CASES.include?(options[:case])
      raise ArgumentError, "Unknown :case option '#{options[:case].inspect}'." +
          " Choose one from: #{CASES.inspect}"
    end

    unless options[:type] != :ordinal || (((0..999).include? number) && (number.is_a? Integer))
      raise ArgumentError, 'for ordinal numbers, number should be integer and in 0..999 range'
    end

    if options[:type] == :ordinal && options[:gender] == :masculine_personal && ((0..4).include? number) == false
      raise ArgumentError, 'for ordinal numbers and masculine personal gender, number should be in 0..4 range'
    end

    unless (0..999999999).include? number
      raise ArgumentError, 'number should be in 0..999999999 range'
    end
    options
  end

  def self.translate(number, options={})

    options = validate(number, options)

    options[:cents] ||= :auto
    options[:type] ||= :cardinal
    options[:gender] ||= :masculine
    options[:case] ||= :nominative
    number = number.to_i if options[:cents]==:no
    formatted_number = sprintf('%012.2f', number)
    currency = CURRENCIES[options[:currency] || :NO]

    digits = formatted_number.chars.map { |char| char.to_i }
    result = process_1_999999999(digits[0..8], options, number, currency)

    process_99_0(result, digits, options, formatted_number[-2..-1], currency)

  end

  def self.add_currency(name, hash)
    CURRENCIES[name]=hash
  end

  private

  def self.process_99_0(result, digits, options, formatted_sub_number, currency)
    if options[:cents] == :words ||
        (options[:cents] == :auto && formatted_sub_number != '00')
      digits_cents = digits[-3..-1] if digits
      number_cents = formatted_sub_number.to_i
      unless result.empty?
        if options[:currency]
          result << ', '
        else
          result << ' i '
        end
      end
      result << process_0_999(digits_cents, number_cents, currency[:gender_100] || :hi, options, false) if digits
      result << ZERO.dup if formatted_sub_number == '00'
      result.strip!
      result << ' '
      result << currency[classify(formatted_sub_number.to_i, digits_cents, true)]
    elsif options[:cents] == :digits
      result << ' '
      result << formatted_sub_number
      result << '/100'
    end

    result
  end

  def self.process_1_999999999(digits, options, number, currency)
    if number == 0 || (number.to_i == 0 && [:words, :digits].include?(options[:cents]))
      if options[:type] == :ordinal
        result = ZERO_ORDINALS.dup
        if result != ''
          if options[:case] == :nominative
            if options[:gender] == :masculine
              result
            elsif options[:gender] == :feminine
              result = result.reverse.sub(result[-2], 'a').reverse
            elsif options[:gender] == :neuter || options[:gender] == :non_masculine
              result = result.reverse.sub(result[-2], 'e').reverse
            else
              result
            end
          elsif options[:case] == :instrumental
            if options[:gender] == :masculine
              result << hundred.sub(' ', 'm ')
            else
              ''
            end
          end
        else
          result
        end
      else
        result = ZERO.dup
      end
    else
      result = ''
      result << process_0_999(digits[0..2], number, :number, options, false)
      result << millions(number.to_i/1000000, digits[0..2])
      result.strip!
      result << ' '
      result << process_0_999(digits[3..5], number, :number, options, false)
      result << thousands(number.to_i/1000, digits[3..5])
      result.strip!
      result << ' '
      result << process_0_999(digits[6..8], number, currency[:gender] || options[:gender] || :hi, options, true)
      result.strip!
    end

    if options[:currency] && !result.empty?
      result << ' ' + currency[classify(number.to_i, digits)]
    end
    result
  end

  def self.process_0_999(digits, number, object, options, is_last)
    result = ''
    if options[:type] == :ordinal
      if digits[1] == 0 && digits[2] == 0
        hundred = HUNDREDS_ORDINALS[digits[0]]
        if hundred != ''
          if options[:case] == :nominative
            if options[:gender] == :masculine
              result << hundred
            elsif options[:gender] == :feminine
              result << hundred.reverse.sub(hundred[-2], 'a').reverse
            elsif options[:gender] == :neuter || options[:gender] == :non_masculine
              result << hundred.reverse.sub(hundred[-2], 'e').reverse
            else
              result << hundred
            end
          elsif options[:case] == :instrumental
            if options[:gender] == :masculine
              result << hundred.sub(' ', 'm ')
            else
              ''
            end
          end
        end
      else
        result << HUNDREDS[digits[0]]
      end
      if digits[1] == 1 && digits[2] != 0
        teen = TEENS_ORDINALS[digits[2]]
        if teen != ''
          if options[:case] == :nominative
            if options[:gender] == :masculine
              result << teen
            elsif options[:gender] == :feminine
              result << teen.reverse.sub(teen[-2], 'a').reverse
            elsif options[:gender] == :neuter || options[:gender] == :non_masculine
              result << teen.reverse.sub(teen[-2], 'e').reverse
            else
              result << teen
            end
          elsif options[:case] == :instrumental
            if options[:gender] == :masculine
              result << teen.sub(' ', 'm ')
            else
              ''
            end
          end
        end
      else
        ten = TENS_ORDINALS[digits[1]]
        if ten != ''
          if options[:case] == :nominative
            if options[:gender] == :masculine
              result << ten
            elsif options[:gender] == :feminine
              result << ten.reverse.sub(ten[-2], 'a').reverse
            elsif options[:gender] == :neuter || options[:gender] == :non_masculine
              result << ten.reverse.sub(ten[-2], 'e').reverse
            else
              result << ten
            end
          elsif options[:case] == :instrumental
            if options[:gender] == :masculine
              result << ten.sub(' ', 'm ')
            else
              ''
            end
          end
        end
        result << process_0_9(digits, number, object, options, is_last)
      end
    else
      result << HUNDREDS[digits[0]]

      if digits[1] == 1 && digits[2] != 0
        result << TEENS[digits[2]]
      else
        result << TENS[digits[1]]
        result << process_0_9(digits, number, object, options, is_last)
      end
    end

    result
  end

  def self.process_0_9(digits, number, object, options, is_last)
    if options[:type] == :ordinal
      unity = UNITIES_ORDINALS[digits[2]]
      if unity != ''
        if options[:case] == :nominative
          if options[:gender] == :masculine
            unity
          elsif options[:gender] == :feminine
            unity.reverse.sub(unity[-2], 'a').reverse
          elsif options[:gender] == :neuter || options[:gender] == :non_masculine
            if unity[-2] == 'i'
              unity.reverse.sub(unity[-1], ' e').reverse
            else
              unity.reverse.sub(unity[-2], 'e').reverse
            end
          elsif options[:gender] == :masculine_personal
            if digits[2] == 0 && object == :she
              'zerowi '
            elsif digits[2] == 1
              'pierwsi '
            elsif digits[2] == 2
              'drudzy '
            elsif digits[2] == 3
              'trzeci '
            elsif digits[2] == 4
              'czwarci '
            end
          else
            unity
          end
        elsif options[:case] == :instrumental
          if options[:gender] == :masculine
            unity.sub(' ', 'm ')
          else
            ''
          end
        end
      else
        unity
      end
    else
      if digits[2] == 2 && is_last && (object == :she || options[:gender] == :feminine)
        'dwie '
      elsif digits[2] != 0 && number == 1 && (object == :she || options[:gender] == :feminine)
        'jedna '
      elsif digits[2] != 0 && number == 1 && (object == :it || options[:gender] == :neuter)
        'jedno '
      elsif digits == [0,0,1] && object == :number
        ''
      else
        UNITIES[digits[2]]
      end
    end
  end

  def self.thousands(number, digits)
    if number == 0 || digits == [0, 0, 0]
      ''
    else
      THOUSANDS[classify(number, digits)]
    end
  end

  def self.millions(number, digits)
    if number == 0 || digits == [0, 0, 0]
      ''
    else
      MILLIONS[classify(number, digits)]
    end
  end

  def self.classify(number, digits, cents=false)
    if number == 1
      return :one_100 if cents
      :one
      # all numbers with 2, 3 or 4 at the end, but not teens
    elsif digits && (2..4).include?(digits[-1]) && digits[-2] != 1
      return :few_100 if cents
      :few
    else
      return :many_100 if cents
      :many
    end
  end
end
