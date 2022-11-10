module Yandex
  class TranslateError < StandardError
  end

  class Translate
    def base_url
      'https://translate.yandex.net/api/v1.5/tr.json/translate'
    end

    def key
      'trnsl.1.1.20190813T190856Z.1cdeb2fba353adbc.884b8535340b746a4ec0bd5cecac523fd59ec5e8'
    end

    #
    # @note Действует ограничение на 1 000 000 символов в день и на 10 000 000 символов в месяц
    #
    def translate(string)
      return string if string.blank?

      response = HttpClient.get(base_url, query: { key: key, text: string, lang: 'ru-en' })
      unless response.code == 200
        Rails.logger.error(response)
        raise TranslateError
      end

      response['text']
    end
  end
end
