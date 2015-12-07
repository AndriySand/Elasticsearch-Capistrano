class RecordsIndex < Chewy::Index
  define_type Record do
    field :value
  end
end