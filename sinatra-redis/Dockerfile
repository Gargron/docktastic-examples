FROM cloudgear/ruby:2.2-onbuild
MAINTAINER Eugen Rochko <eugen@zeonfederated.com>

EXPOSE 3000

CMD ["bundle", "exec", "unicorn", "-c", "unicorn.rb", "-p", "3000"]
