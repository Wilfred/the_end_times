# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
#
# contributed by Gabriele Renzi

require "big_int"

class PiDigitSpigot 

    def initialize()
        @y = 0
        @z = Transformation.new 1,0,0,1
        @x = Transformation.new 0,0,0,0
        @inverse = Transformation.new 0,0,0,0
    end

    def next!
        @y = @z.extract(3) 
        if safe? @y
            @z = produce(@y)
            @y
        else 
            @z = consume @x.next!() 
            next!()
        end
    end

    def safe?(digit)
        digit == @z.extract(4)
    end

    def produce(i)
        @inverse.qrst(10,-10*i,0,1).compose(@z)
    end

    def consume(a)
        @z.compose(a)
    end
end


class Transformation
    
    getter :q, :r, :s, :t
    
    def initialize (q, r, s, t, @k = 0)
        @q, @r, @s, @t = q.to_big_i, r.to_big_i, s.to_big_i, t.to_big_i
    end

    def next!()
        @q = @k = @k + 1
        @r = 4 * @k + 2
        @s = 0
        @t = 2 * @k + 1
        self
    end

    def extract(j)
        (@q * j + @r) / (@s * j + @t).to_big_i
    end

    def compose(a)
        self.class.new( @q * a.q,
                        @q * a.r + r * a.t,
                        @s * a.q + t * a.s,
                        @s * a.r + t * a.t
                    ) 
    end

    def qrst *args
        initialize *args
        self
    end


end


WIDTH = 10
n = ARGV[0].to_i
j = 0

digits = PiDigitSpigot.new

while n > 0
    if n >= WIDTH
        WIDTH.times {print digits.next!}
        j += WIDTH
    else 
        n.times {print digits.next!}
        (WIDTH-n).times {print " "} 
        j += n
    end
    puts "\t:"+j.to_s
    n -= WIDTH
end
