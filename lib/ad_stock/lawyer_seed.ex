defmodule AdStock.LawyerSeed do

  @lawyer_names ["Bob Loblaw", "Geovanny Wolff Sr.", "Joannie Johns", "Lavonne Borer", "Beulah Wilkinson DDS",
    "Dewitt Runolfsson II", "Bette Bauch", "Ms. Estrella Kuhic", "Abelardo Kunde", "Miss Mariane Schinner"]

  alias AdStock.Lawyer
  alias AdStock.Repo

  def run() do
    Repo.delete_all(Lawyer)
    Enum.each(Enum.with_index(@lawyer_names), fn({name, id}) ->
      %Lawyer{lawyer_id: id, name: name, current_balance: 0}
      |> Lawyer.changeset
      |> Repo.insert!
    end)
  end
end
