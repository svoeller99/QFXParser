require './qfxparser.rb'

my_transactions = QFXParser.new.parse '/home/sean/Downloads/ChaseOutputSamples/JPMC_Small.QFX'

my_transactions.each do |tx|
  puts tx
end