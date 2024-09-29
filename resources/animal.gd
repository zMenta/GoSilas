extends Resource

var id: int
var adopter_id: int = 0
var address_id: int = 0

var image: ImageTexture
var is_castrated: bool
enum Sex {Male, Female}
enum Size {SMALL, MEDIUM, BIG, EXTRA_BIG}
enum Character {FRIENDLY, AGRESSIVE}
var health_state: String
