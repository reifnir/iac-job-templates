resource "random_pet" "this" {
  length    = 2
  separator = "-"
}

output "pet_name" {
  value = random_pet.this.id
}
