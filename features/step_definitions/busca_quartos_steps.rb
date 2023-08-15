Given('eu estou na tela de busca de quartos') do
  visit '/buscar_quartos'
end

Given('existe um quarto ja cadastrado com numero {int}') do |numero_quarto|
  visit '/quartos/new'
  fill_in 'Numero', with: numero_quarto
  fill_in 'Preco', with: 9.99
  fill_in 'Capacidade', with: 1
  click_button 'Cadastrar quarto'
end

When('eu informo o numero {string} e clico em Buscar') do |numero_quarto|
  visit '/buscar_quartos'
  fill_in 'numero', with: numero_quarto
  click_button 'Filtrar'
end

Then('o sistema deve retornar o {string} quarto encontrado na lista de resultados') do |numero_quarto|
  expect(page).to have_content("Lista de Quartos")
  expect(page).to have_content(numero_quarto)
end

Given('nao existe um quarto cadastrado com numero {float}') do |float|
  visit "/quartos"
  expect(page).not_to have_content(float)
end

Then('o sistema deve mostrar que nenhum quarto foi encontrado') do
  expect(page).to have_content("Nenhum quarto encontrado.")
end

Given('existe um quarto cadastrado com capacidade para {int} hospedes') do |capacidade|
  visit '/quartos/new'
  fill_in 'Numero', with: 14
  fill_in 'Preco', with: 29.99
  fill_in 'Capacidade', with: capacidade
  click_button 'Cadastrar quarto'
end

When('eu informo a quantidade de hospedes {string} e clico em Buscar') do |intervalo_hospedes|
  visit '/buscar_quartos'
  expect(page).to have_select('quantidade_hospedes_intervalo', with_options: [intervalo_hospedes])
  select intervalo_hospedes, from: 'quantidade_hospedes_intervalo'
  click_button 'Filtrar'
end

Then('o sistema deve retornar o quarto encontrado com capacidade de {string} na lista de resultados') do |capacidade|
  expect(page).to have_content("Lista de Quartos")
  expect(page).to have_content(capacidade)
end

Given('nao existe um quarto cadastrado com capacidade para {int} hospedes') do |int|
  visit "/quartos"
  expect(page).not_to have_content(int)
end

Given('existe um quarto cadastrado com preco de {int} reais') do |valor|
  visit '/quartos/new'
  fill_in 'Numero', with: 14
  fill_in 'Preco', with: valor
  fill_in 'Capacidade', with: 10
  click_button 'Cadastrar quarto'
end

When('eu informo a faixa de preco {string} e clico em Buscar') do |faixa_preco|
  visit '/buscar_quartos'
  expect(page).to have_select('faixa_preco_intervalo', with_options: [faixa_preco])
  select faixa_preco, from: 'faixa_preco_intervalo'
  click_button 'Filtrar'
end

Then('o sistema deve retornar o quarto encontrado com valor de {float} reais na lista de resultados') do |valor|
  expect(page).to have_content("Lista de Quartos")
  expect(page).to have_content(valor)
end
