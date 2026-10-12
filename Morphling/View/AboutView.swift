import SwiftUI

private struct HLabel: View {
    var title: LocalizedStringKey
    var systemImage: String

    var body: some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: systemImage).frame(width: 16)
        }
    }
}

private struct ClickableImage: View {
    @Environment(\.openURL) var openURL

    var img: String
    var help: LocalizedStringKey
    var url: String

    var body: some View {
        Image(img)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(Color.accentColor)
            .frame(width: 14, height: 14)
            .help(help)
            .onTapGesture {
                openURL(URL(string: url)!)
            }
    }
}

private struct CandyTag: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .lineLimit(1)
            .foregroundStyle(Color.accentColor)
            .padding(.vertical, 1)
            .padding(.horizontal, 4)
            .background(Color.accentColor.opacity(0.2).gradient)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct AboutView: View {
    var VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var BUILD = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(nsImage: NSApplication.shared.applicationIconImage)
                .resizable()
                .frame(width: 128, height: 128)
                .padding(.leading, 20)
                .padding(.top, 8)

            Form {
                Section {
                    if let VERSION, let BUILD {
                        LabeledContent(
                            content: { Text(VERSION + " (" + BUILD + ")") },
                            label: { HLabel(title: "About.Version", systemImage: "hammer") }
                        )
                    }

                    LabeledContent(
                        content: {
                            Link(
                                "shensven/Morphling",
                                destination: URL(string: "https://github.com/shensven/Morphling")!
                            )
                        },
                        label: {
                            HLabel(title: "About.Source_Code", systemImage: "chevron.left.forwardslash.chevron.right")
                        }
                    )
                }

                Section(
                    content: {
                        LabeledContent(
                            content: {
                                HStack {
                                    ClickableImage(
                                        img: "RiGithubFill",
                                        help: "GitHub",
                                        url: "https://github.com/shensven"
                                    )
                                    ClickableImage(
                                        img: "RiTwitterFill",
                                        help: "Twitter",
                                        url: "https://twitter.com/shensven2016"
                                    )
                                    ClickableImage(
                                        img: "RiWeiboFill",
                                        help: "About.Weibo",
                                        url: "https://weibo.com/u/2449440940"
                                    )
                                }
                            },
                            label: {
                                HLabel(title: "About.Developer", systemImage: "person")
                            }
                        )
                    },
                    footer: {
                        HStack(spacing: 0) {
                            Text("Made with ❤️ in Kunming by").font(.caption).foregroundStyle(.secondary)
                            Text(" ").font(.caption).foregroundStyle(.secondary)
                            Link(
                                destination: URL(string: "https://github.com/shensven")!,
                                label: { CandyTag(title: "SvenFE") }
                            )
                        }
                    }
                )
            }
            .formStyle(.grouped)
        }
    }
}

#Preview {
    AboutView()
}
