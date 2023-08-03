Given('estou na página de cadastro de reservas') do
  visit new_reserva_path
end

When('preencho o formulário com cliente {string}, quarto {int}, data de entrada {string} e saída {string}') do |nome_completo, quarto, entrada, saida|
  select nome_completo, from: 'Cliente'
  fill_in 'Quarto', with: quarto
  fill_in 'Entrada', with: entrada
  fill_in 'Saida', with: saida
end

When('eu clico no botão Reservar quarto') do
  click_button 'Reservar quarto'
end

Then('eu vejo a reserva do quarto {int} cadastrada no nome de {string}') do |quarto, nome_completo|
  expect(page).to have_content(quarto)
  expect(page).to have_content(nome_completo)
end

Given('o quarto {int} está reservado para {string}, com entrada em {string} e saída {string}') do |quarto, nome_completo, entrada, saida|
  visit new_reserva_path
  select nome_completo, from: 'Cliente'
  fill_in 'Quarto', with: quarto
  fill_in 'Entrada', with: entrada
  fill_in 'Saida', with: saida
  click_button 'Reservar quarto'
end

Given('estou na lista de reservas') do
  visit reservas_path
end

When('eu clico na opção Visualizar reserva') do
  click_link 'Visualizar reserva'
end

When('eu atualizo o formulário com o quarto {int}') do |novo_quarto|
  fill_in 'Quarto', with: novo_quarto
end

Then('o quarto {int} deve estar reservado para {string}') do |novo_quarto, nome_completo|
  expect(page).to have_content(novo_quarto)
  expect(page).to have_content(nome_completo)
end

Then('devo ver uma mensagem de erro informando que a data {string} é inválida') do |data|
  if data.include? 'Entrada'
    expect(page).to have_content('Entrada deve ser futura a hoje')
  end
  if data.include? 'Saida'
    expect(page).to have_content('Saida deve ser futura à entrada')
  end
end

Then('devo ver uma mensagem de erro informando que o quarto {int} já está reservado de {string} até {string}') do |quarto, entrada, saida|
  eformat = Date.parse(entrada).strftime('%d/%m/%Y')
  sformat = Date.parse(saida).strftime('%d/%m/%Y')
  expect(page).to have_content("Quarto #{quarto} já está reservado de #{eformat} até #{sformat}")
end

When('eu clico no botão Deletar') do
  click_on 'Deletar'
end

Then('a reserva do quarto {int} de {string} não deve constar na lista de reservas') do |quarto, nome_completo|
  expect(page).not_to have_content("Quarto: #{quarto}")
  expect(page).not_to have_content("Cliente: #{nome_completo}")
end