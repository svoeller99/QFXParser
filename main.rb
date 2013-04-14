input_file_name = '/home/sean/Downloads/ChaseOutputSamples/JPMC_Small.QFX'

#<STMTTRN>
#<TRNTYPE>DEBIT
#<DTPOSTED>20130412120000[0:GMT]
#<TRNAMT>-11.65
#<FITID>201304124
#<NAME>#00582 ALBERTSONS PORTLAND OR
#<MEMO>076024  04/12
#</STMTTRN>

def parse input_file_name
  in_tx = false

  all_transactions = []

  current_tx = {}

  IO.foreach(input_file_name) do |line|
    line.strip!

    starting_tx = line.eql? "<STMTTRN>"
    ending_tx = line.eql? "</STMTTRN>"

    if starting_tx
      in_tx = true
      current_tx = {}

      all_transactions.push current_tx
    end

    if in_tx && !starting_tx && !ending_tx
      if line =~ /^<(.*?)>(.*?)$/
        current_tx[[$1]] = [$2]
      end
    end

    if ending_tx
      in_tx = false
    end
  end

  return all_transactions
end

my_transactions = parse input_file_name

my_transactions.each do |tx|
  puts tx
end