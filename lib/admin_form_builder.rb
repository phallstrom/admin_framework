class AdminFormBuilder < ActionView::Helpers::FormBuilder

  def file_field(method, options = {})
    original_options, options = prepare_options('file', options)
    if defined?(Paperclip::Attachment) && object.send(method).is_a?(Paperclip::Attachment)
      original_options[:errors_on] ||= ["#{method}_file_name", "#{method}_file_size", "#{method}_content_type"]
    end
    wrapped_field(method, original_options, super)
  end

  def text_field(method, options = {})
    original_options, options = prepare_options('text', options)
    wrapped_field(method, original_options, super)
  end

  def password_field(method, options = {})
    original_options, options = prepare_options('text password', options)
    wrapped_field(method, original_options, super)
  end

  def text_area(method, options = {})
    original_options, options = prepare_options('text textarea', options)
    wrapped_field(method, original_options, super)
  end

  def check_box(method, options = {})
    original_options, options = prepare_options('checkbox', options)
    wrapped_field(method, original_options, super)
  end

  def select(method, choices, options = {}, html_options = {})
    original_options, options = prepare_options('select', options)
    wrapped_field(method, original_options, super)
  end

  def date_select(method, options = {}, html_options = {})
    original_options, options = prepare_options('date_select', options)
    wrapped_field(method, original_options, super)
  end

  def datetime_select(method, options = {}, html_options = {})
    original_options, options = prepare_options('datetime_select', options)
    wrapped_field(method, original_options, super)
  end

  def time_select(method, options = {}, html_options = {})
    original_options, options = prepare_options('time_select', options)
    wrapped_field(method, original_options, super)
  end

  def wrap_field(method, options = {})
    original_options, options = prepare_options('', options)
    wrapped_field(method, original_options, yield)
  end

   def static_field(method, options = {})
     original_options, options = prepare_options('static', options)
     wrapped_field(method, original_options, options[:value] || object.send(method))
   end

  def form_buttons
    %Q{
    <div class="form_buttons">
      #{yield}
    </div>
    }
  end

  def cancel(options = {})
    options = {:label => 'cancel', :name => 'cancel', :class => 'cancel button'}.merge(options)
    options[:onclick] ||= ''
    options[:onclick] << " ;return(false);"
    submit(options.delete(:label), options)
  end

  protected ############################################################

  def prepare_options(classes, options)
    original_options = options.dup
    options[:class] ||= ''
    options[:class] << " #{classes}"
    options[:class] << ' required' if options.delete(:required)
    options.reject! {|k,v| [:required,:help].include?(k) } 

    [original_options, options]
  end

  def wrapped_field(method, options, field)
    return field if options[:field_only] == true

    %Q{
    <div class="field #{'required' if options[:required]}">
      #{label method, (options.delete(:label) || method.to_s.humanize.titleize)}
      <div style="display: inline-block">
        #{field}
        #{"<div class='help'>#{options[:help]}</div>" if options[:help]}
        #{ [method, options[:errors_on]].flatten.compact.to_a.map{|m| object.errors.on(m).to_a.map {|e| "<div class='error'>#{e.capitalize}.</div>" } }}
      </div>
    </div>
    }
  end

end
