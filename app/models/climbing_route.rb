class ClimbingRoute < ApplicationRecord
  validates :name,  presence: true

  belongs_to :sector, dependent: :destroy
  has_many :ascents, dependent: :nullify
  belongs_to :route_grade
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }

  scope :in_crag_and_sector, lambda { |sector_id, crag_id|
                                      joins(:sector)
                                      .where(sector_id: sector_id)
                                      .where('sectors.crag_id = ?', crag_id)
                                    }
  scope :show_all_climbing_routes,
        -> {
          eager_load(sector: :crag)
            .all
            .order(:name)
        }
end
