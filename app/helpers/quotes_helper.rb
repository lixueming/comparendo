module QuotesHelper
	def build_project_option_field q
		if q.checkbox?
      return build_checkboxes_field(q)
    end

    if q.select?
    	return build_select_field(q)
		end

		if q.custom?
			return build_text_field(q)
    end
	end

	def build_checkboxes_field q
		res = []
		q.answers.each do |a|
    	indx = project_option_indx
    	f = check_box_tag("project[project_options_attributes][#{indx}][answer_id]", a.id)
    	f += label_tag("project_project_options_attributes_#{indx}_answer_id", a.description, style: "display: inline;")
    	res << content_tag(:fieldset, f)
    end
    res.join("").html_safe
	end

	def build_select_field q
		res = "<select name='project[project_options_attributes][#{project_option_indx}][answer_id]'>"
    q.answers.each do |a|
	    res += "<option value='#{a.id}'>#{a.description}</option>"
    end
	  res += "</select>"
	  res.html_safe
	end

	def build_text_field q
		indx = project_option_indx
    res = text_area_tag "options[#{indx}][answer][description]", nil, cols: 40, rows: 5, class: 'custom_question'
    res += hidden_field_tag "options[#{indx}][answer][question_id]", q.id
    res.html_safe
	end

	def project_option_indx
		"#{SecureRandom.hex(3)}#{Time.now.to_i}"
	end
end
