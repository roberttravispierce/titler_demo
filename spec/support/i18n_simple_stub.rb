module I18n
  module Backend
    class SimpleStub
      def exists?(key, *args)
        false
      end
    end
  end
end
