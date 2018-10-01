class Place < OpenStruct
  def self.rendered_fields
    # TAULUKKO - index ym. näkymät voivat hyödyntää näitä "fieldejä" looppaamalla
    [:id, :name, :status, :street, :city, :zip, :country, :overall]
  end
end