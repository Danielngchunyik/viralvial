module NestedFormsHelper
  def link_to_add_fields(name, f, association, extra_name)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id

    if extra_name == ""
      header_name = extra_name
    else
      header_name = extra_name + "_"
    end

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(header_name + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end