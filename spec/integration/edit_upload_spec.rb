require "spec_helper"

describe "an upload", type: :feature do
    include Capybara::DSL

  it "can be updated" do
    admin = create(:user, admin: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin)
    upload = create(:upload)
    old_meaning = upload.meaning

    visit edit_upload_path(upload)
    fill_in("significado", with: "chivo")
    fill_in("inglés", with: "goat")
    click_link_or_button("Guardar")

    expect(current_path).to eq(dashboard_path)
    expect(page).not_to have_content(old_meaning)
    expect(page).to have_content("chivo")
    expect(page).to have_content("goat")
  end

  it "can be have the changes cancelled" do
    admin = create(:user, admin: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin)
    upload = create(:upload)
    old_meaning = upload.meaning

    visit edit_upload_path(upload)
    fill_in("significado", with: "chivo")
    fill_in("inglés", with: "goat")
    click_link_or_button("Cancelar")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(old_meaning)
    expect(page).not_to have_content("chivo")
    expect(page).not_to have_content("goat")
  end
end
