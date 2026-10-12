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
    @Environment(\.openURL) var openURL

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
                            Link(destination: URL(string: "https://github.com/shensven/Morphling")!) {
                                Text(verbatim: "shensven/Morphling")
                            }
                        },
                        label: {
                            HLabel(
                                title: "About.Source_Code",
                                systemImage: "chevron.left.forwardslash.chevron.right"
                            )
                        }
                    )
                }

                Section(
                    content: {
                        LabeledContent(
                            content: {
                                Button("About.Feedback_on_GitHub") {
                                    openURL(URL(string: "https://github.com/shensven/Morphling/issues")!)
                                }.controlSize(.small)
                            },
                            label: {
                                HLabel(title: "About.Feedback", systemImage: "exclamationmark.bubble")
                            }
                        )
                    },
                    footer: {
                        HStack(spacing: 4) {
                            Text(verbatim: "Made with ❤️ in Kunming by").font(.caption).foregroundStyle(.secondary)
                            Link(
                                destination: URL(string: "https://x.com/eks_sven")!,
                                label: { CandyTag(title: "Sven") }
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
