import SwiftUI

struct AboutView: View {
    var VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var BUILD = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(nsImage: NSApplication.shared.applicationIconImage)
                .resizable()
                .frame(width: 128, height: 128)
                .padding(.leading, 16)

            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Yadds").font(.title)
                        Spacer()
                        Text("Version \(VERSION!) (Build \(BUILD!))").foregroundColor(.secondary)
                    }

                    Divider().padding(.bottom)

                    HStack {
                        Image("RiAtLine")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 16, height: 16)
                        Text("About.Developer")
                        Spacer()

                        Image("RiGithubFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("GitHub")
                            .onTapGesture {
                                NSWorkspace.shared.open(
                                    URL(string: "https://github.com/shensven")!
                                )
                            }

                        Image("RiTwitterFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("Twitter")
                            .onTapGesture {
                                NSWorkspace.shared.open(
                                    URL(string: "https://twitter.com/shensven2016")!
                                )
                            }

                        Image("RiWeiboFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("About.Weibo")
                            .onTapGesture {
                                NSWorkspace.shared.open(
                                    URL(string: "https://weibo.com/u/2449440940")!
                                )
                            }
                    }

                    HStack {
                        Image("RiStarSmileLine")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 16, height: 16)
                        Text("About.Give_a_Good_Review")
                        Spacer()
                        Image("RiAppStoreFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("Mac App Store")
                        Image("RiProductHuntFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("Product Hunt")
                    }

                    HStack {
                        Image("RiBracesFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 16, height: 16)
                        Text("About.Source_Code")
                        Spacer()
                        Image("RiGithubFill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .frame(width: 16, height: 16)
                            .help("GitHub")
                            .onTapGesture {
                                NSWorkspace.shared.open(
                                    URL(string: "https://github.com/shensven/Morphling")!
                                )
                            }
                    }

                    HStack {
                        Image("RiServiceLine")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 16, height: 16)
                        Text("About.Improve_Translation")
                        Spacer()
                        Image("crowdin-icon")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.accentColor)
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .help("Crowdin")
                            .onTapGesture {
                                NSWorkspace.shared.open(
                                    URL(string: "https://crowdin.com/project/morphling")!
                                )
                            }
                    }

                    Divider().padding(.top)
                    HStack {
                        Text("Made with ❤️ in Kunming by SvenFE").foregroundColor(.secondary).font(.subheadline)
                        Spacer()
                    }

                }.padding()
            }.scrollIndicators(.hidden)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
