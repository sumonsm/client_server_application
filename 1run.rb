puts 'start'


# random = File.read("/dev/urandom", 64).unpack("H*")[0]
# random = File.read("/dev/urandom", 1024).unpack('C*').map {|x| x.chr(Encoding::UTF_8)}.join
# random = File.read("/dev/urandom", 1024).unpack('C*').pack('U*').gsub(/\W+/, "*")
# random = File.read("/dev/urandom", 1024).unpack('C*').pack('U*').gsub(/\W+/, "*")
p random = File.read("/dev/urandom", 1024).encode("UTF-8", invalid: :replace, undef: :replace)
# random = "hi∑"
#p random = "Taiwanese(6): Góa ē-tàng chia̍h po-lê, mā bē tio̍h-siong.
# Japanese: 私は    ガラスを食べられます。それは私を傷つけません。
# Korean: 나는 유리를   먹을 수 있어요. 그래도 아프지 않아요"

#puts 'random:'
#puts random.encode("UTF-8", invalid: :replace, undef: :replace).gsub(/\s/, "*")

# p x = "tür ☺".unpack('U*')
# p y = "tür ☺".unpack('C*')
# puts x.pack('U*')
# puts y.pack('U*')

#p z = random.unpack('U*')
p random.gsub(/\s/, "*")

#puts random.pack('U*')
exit 0