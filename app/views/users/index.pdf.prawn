pdf.text "#{params[:provider].camelize} Users", size: 30, style: :bold
pdf.move_down(30)
users = instance_variable_get("@" + params[:provider] + "_users")
data = users.all.map {|user|
  if user.image.present?
  img = user.image.path
   [user.name, user.email, user.provider, {:image => img, :image_width => 50, :image_height => 50 }]
  else
   [user.name, user.email, user.provider || "Other", "No image available"]
  end
}
data.insert(0, ["Name", "Email", "Provider", "Image"])
pdf.table data, {:header => true} do |table|
  table.header=(["Name", "Email", "Provider", "Image"])
  table.row(0).font_style = :bold
end

