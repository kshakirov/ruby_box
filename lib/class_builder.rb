class_name = 'MyScript'

klass_body = %Q{
    class #{class_name}
      def run batch
        batch.map do |i|
          puts i
        end
      end
    end
    }
klass = eval(klass_body)
p klass.class
script = MyScript.new
script.run [1,2,3,4]

klass = Object.const_get('MyScript')
p klass.name

p klass.new