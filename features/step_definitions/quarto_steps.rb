Given('estou na pagina de cadastro de quartos') do
  visit new_quarto_path
end

When('preencho o formulario com numero {int} preco {float} e capacidade {int}') do |numero, preco, capacidade|
  fill_in 'Numero', with: numero
  fill_in 'Preco', with: preco
  fill_in 'Capacidade', with: capacidade
end

When('eu clico no botao Cadastrar quarto') do
  click_button 'Cadastrar quarto'
end

Then('eu vejo o quarto {int} cadastrado') do |quarto|
  expect(page).to have_content('success')
  expect(page).to have_content("Numero: #{quarto}")
end

Given('existe um quarto cadastrado com numero {int}') do |quarto|
  visit new_quarto_path
  fill_in 'Numero', with: quarto
  fill_in 'Preco', with: 9.99
  fill_in 'Capacidade', with: 1
  click_button 'Cadastrar quarto'
end

Given('estou na lista de quartos') do
  visit quartos_path
end

When('eu vejo o quarto {int}') do |quarto|
  expect(page).to have_content("Numero: #{quarto}")
end

When('eu clico na opcao Visualizar quarto') do
  click_on 'Visualizar quarto'
end

Then('devo ver uma mensagem de erro informando que o {string} do quarto e invalido') do |parametro|
  expect(page).to have_content("#{parametro.capitalize} deve ser maior que 0")
end

Then('o quarto {int} nao deve constar na lista de quartos') do |quarto|
  expect(page).not_to have_content("Numero #{quarto}")
end