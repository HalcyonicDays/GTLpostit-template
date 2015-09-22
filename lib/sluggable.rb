module Sluggable
  extend ActiveSupport::Concern

  included do 
    class_attribute :slug_column
    after_validation :generate_slug!
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    my_object = self.class.find_by(slug: the_slug)
    count = 2
    while my_object && my_object != self
      the_slug = append_suffix(the_slug, count)
      my_object = self.class.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug
  end

  def to_slug(string)
    slug = string.match(/\W/) ? string.gsub(/\W/, '-') : string
    slug = slug.gsub!(/-{2,}/, '-') if slug.match(/-{2,}/)
    slug = slug.slice(0...-1) if slug.slice(-1) == '-'
    slug.downcase
  end

  def append_suffix(slug, count)
    if slug.split('-').last.to_i == 0
      return slug << "-#{count}"
    else
      return slug.split('-').slice(0..-1).join('-') << "-#{count}"
    end
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end