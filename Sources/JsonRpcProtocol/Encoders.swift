/*
 * Copyright (c) Kiad Studios, LLC. All rights reserved.
 * Licensed under the MIT License. See License in the project root for license information.
 */

import JSONLib
import LanguageServerProtocol

#if os(macOS)
import os.log
#endif

@available(macOS 10.12, *)
fileprivate let log = OSLog(subsystem: "com.kiadstudios.jsonrpcprotocol", category: "TSEncodable")

extension JSValue: AnyEncodable {
    public func encode() -> Any {
        return self
    }
}

extension String: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(self)
    }
}

extension Double: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(self)
    }
}

extension Bool: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(self)
    }
}

extension Int: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self))
    }
}

extension TextDocumentSync: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case .options(let options): return options.encode()
        case .kind(let kind): return kind.encode()
        }
    }
}

extension CodeLens: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["range"] = range.encode()
        if let command = command {
            json["command"] = command.encode()
        }
        return json
    }
}

extension CodeLensOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let resolveProvider = resolveProvider {
            json["resolveProvider"] = resolveProvider.encode()
        }
        return json
    }
}

extension Command: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["title"] = title.encode()
        json["command"] = command.encode()
        if let arguments = arguments {
            json["arguments"] = arguments.encode() as? JSValue
        }
        return json
    }
}

extension CompletionOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let resolveProvider = resolveProvider {
            json["resolveProvider"] = resolveProvider.encode()
        }
        if let triggerCharacters = triggerCharacters {
            let values: [JSValue] = triggerCharacters.map { $0.encode() }
            json["triggerCharacters"] = JSValue(values)
        }
        return json
    }
}

extension DocumentHighlight: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["range"] = range.encode()
        if let kind = kind {
            json["kind"] = kind.encode()
        }
        return json
    }
}

extension DocumentLink: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["range"] = range.encode()
        if let target = target {
            json["target"] = target.encode()
        }
        return json
    }
}

extension DocumentLinkOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let resolveProvider = resolveProvider {
            json["resolveProvider"] = resolveProvider.encode()
        }
        return json
    }
}

extension DocumentOnTypeFormattingOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["firstTriggerCharacter"] = firstTriggerCharacter.encode()
        if let moreTriggerCharacter = moreTriggerCharacter {
            json["moreTriggerCharacter"] = JSValue(moreTriggerCharacter.map { $0.encode() })
        }
        return json
    }
}

extension ExecuteCommandOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let commands = commands {
            json["commands"] = JSValue(commands.map { $0.encode() })
        }

        return json
    }
}

extension Hover: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["contents"] = JSValue(contents.map { $0.encode() })
        if let range = range {
            json["range"] = range.encode()
        }
        return json
    }
}

extension InitializeResult: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["capabilities"] = capabilities.encode()
        return json
    }
}

extension Location: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["uri"] = uri.encode()
        json["range"] = range.encode()
        return json
    }
}

extension Position: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["line"] = line.encode()
        json["character"] = character.encode()
        return json
    }
}

extension ServerCapabilities: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let textDocumentSync = textDocumentSync {
            json["textDocumentSync"] = textDocumentSync.encode()
        }
        if let hoverProvider = hoverProvider {
            json["hoverProvider"] = hoverProvider.encode()
        }
        if let completionProvider = completionProvider {
            json["completionProvider"] = completionProvider.encode()
        }
        if let signatureHelpProvider = signatureHelpProvider {
            json["signatureHelpProvider"] = signatureHelpProvider.encode()
        }
        if let definitionProvider = definitionProvider {
            json["definitionProvider"] = definitionProvider.encode()
        }
        if let referencesProvider = referencesProvider {
            json["referencesProvider"] = referencesProvider.encode()
        }
        if let documentHighlightProvider = documentHighlightProvider {
            json["documentHighlightProvider"] = documentHighlightProvider.encode()
        }
        if let documentSymbolProvider = documentSymbolProvider {
            json["documentSymbolProvider"] = documentSymbolProvider.encode()
        }
        if let workspaceSymbolProvider = workspaceSymbolProvider {
            json["workspaceSymbolProvider"] = workspaceSymbolProvider.encode()
        }
        if let codeActionProvider = codeActionProvider {
            json["codeActionProvider"] = codeActionProvider.encode()
        }
        if let codeLensProvider = codeLensProvider {
            json["codeLensProvider"] = codeLensProvider.encode()
        }
        if let documentFormattingProvider = documentFormattingProvider {
            json["documentFormattingProvider"] = documentFormattingProvider.encode()
        }
        if let documentRangeFormattingProvider = documentRangeFormattingProvider {
            json["documentRangeFormattingProvider"] = documentRangeFormattingProvider.encode()
        }
        if let documentOnTypeFormattingProvider = documentOnTypeFormattingProvider {
            json["documentOnTypeFormattingProvider"] = documentOnTypeFormattingProvider.encode()
        }
        if let renameProvider = renameProvider {
            json["renameProvider"] = renameProvider.encode()
        }
        if let documentLinkProvider = documentLinkProvider {
            json["documentLinkProvider"] = documentLinkProvider.encode()
        }
        if let executeCommandProvider = executeCommandProvider {
            json["executeCommandProvider"] = executeCommandProvider.encode()
        }
        return json
    }
}

extension ShowMessageRequestParams: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["type"] = type.encode()
        json["message"] = message.encode()
        if let actions = actions {
            json["actions"] = JSValue(actions.map { $0.encode() })
        }
        return json
    }
}

extension SignatureHelp: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["signatures"] = JSValue(signatures.map { $0.encode() })
        if let activeSignature = activeSignature {
            json["activeSignature"] = activeSignature.encode()
        }
        if let activeParameter = activeParameter {
            json["activeParameter"] = activeParameter.encode()
        }
        return json
    }
}

extension SignatureHelpOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let triggerCharacters = triggerCharacters {
            json["triggerCharacters"] = JSValue(triggerCharacters.map { $0.encode() })
        }
        return json
    }
}

extension SymbolInformation: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["name"] = name.encode()
        json["kind"] = kind.encode()
        json["location"] = location.encode()
        if let containerName = containerName {
            json["containerName"] = containerName.encode()
        }
        return json
    }
}

extension TextDocumentSyncOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let openClose = openClose {
            json["openClose"] = openClose.encode()
        }
        if let change = change {
            json["change"] = change.encode()
        }
        if let willSave = willSave {
            json["willSave"] = willSave.encode()
        }
        if let willSaveWaitUntil = willSaveWaitUntil {
            json["willSaveWaitUntil"] = willSaveWaitUntil.encode()
        }
        if let save = save {
            json["save"] = save.encode()
        }
        return json
    }
}

extension TextEdit: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["range"] = range.encode()
        json["newText"] = newText.encode()
        return json
    }
}



extension LanguageServerProtocol.Range: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["start"] = start.encode()
        json["end"] = end.encode()
        return json
    }
}

extension RequestId: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case let .number(value): return JSValue(Double(value))
        case let .string(value): return JSValue(value)
        }
    }
}

extension DocumentHighlightKind: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension MarkedString: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case let .string(value): return JSValue(value)
        case let .code(language, value):
            return [
                "language": JSValue(language),
                "value": JSValue(value)
            ]
        }
    }
}

extension MessageActionItem: TSEncodable {
    public func encode() -> JSValue {
        return ["title": JSValue(self.title)]
    }
}

extension MessageType: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension SignatureInformation: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["label"] = label.encode()
        if let doc = documentation {
            json["documentation"] = doc.encode()
        }
        if let params = parameters {
            json["parameters"] = JSValue(params.map { $0.encode() })
        }
        return json
    }
}

extension SymbolKind: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension TextDocumentSyncKind: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension CompletionItemKind: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension SaveOptions: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        if let include = includeText {
            json["includeText"] = include.encode()
        }
        return json
    }
}

extension CompletionListResult: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case let .completionItems(items): return JSValue(items.map { $0.encode() })
        case let .completionList(list): return list.encode()
        }
    }
}

extension ParameterInformation: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["label"] = label.encode()
        if let doc = documentation {
            json["documentation"] = doc.encode()
        }
        return json
    }
}

extension DidChangeConfigurationParams: TSEncodable {
    public func encode() -> JSValue {
        return settings.encode() as! JSValue
    }
}


extension CompletionItem: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["label"] = label.encode()

        if let kind = kind {
            json["kind"] = kind.encode()
        }
        if let detail = detail {
            json["detail"] = detail.encode()
        }
        if let documentation = documentation {
            json["documentation"] = documentation.encode()
        }
        if let sortText = sortText {
            json["sortText"] = sortText.encode()
        }
        if let filterText = filterText {
            json["filterText"] = filterText.encode()
        }
        if let insertText = insertText {
            json["insertText"] = insertText.encode()
        }
        if let insertTextFormat = insertTextFormat {
            json["insertTextFormat"] = insertTextFormat.encode()
        }
        if let textEdit = textEdit {
            json["textEdit"] = textEdit.encode()
        }
        if let additionalTextEdits = additionalTextEdits {
            json["additionalTextEdits"] = JSValue(additionalTextEdits.map { $0.encode() })
        }
        if let command = command {
            json["command"] = command.encode()
        }
        if let data = data {
            json["data"] = data.encode() as? JSValue
        }

        return json
    }
}

extension CompletionList: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["isIncomplete"] = isIncomplete.encode()
        json["items"] = JSValue(items.map { $0.encode() })
        return json
    }
}

extension InsertTextFormat: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension WorkspaceEdit: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case let .changes(changes):
            var json: JSValue = [:]
            for (key, value) in changes {
                json[key] = JSValue(value.map { $0.encode() })
            }
            return json
        case let .documentChanges(changes): return JSValue(changes.map { $0.encode() })
        }
    }
}

extension TextDocumentEdit: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["textDocument"] = textDocument.encode()
        json["edits"] = JSValue(edits.map { $0.encode() })
        return json
    }
}

extension VersionedTextDocumentIdentifier: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["uri"] = uri.encode()
        json["version"] = version.encode()
        return json
    }
}

extension Diagnostic: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["range"] = range.encode()
        json["message"] = message.encode()
        if let severity = severity {
            json["severity"] = severity.encode()
        }
        if let code = code {
            json["code"] = code.encode()
        }
        if let source = source {
            json["source"] = source.encode()
        }
        return json
    }
}

extension DiagnosticCode: TSEncodable {
    public func encode() -> JSValue {
        switch self {
        case let .number(value): return value.encode()
        case let .string(value): return value.encode()
        }
    }
}

extension DiagnosticSeverity: TSEncodable {
    public func encode() -> JSValue {
        return JSValue(Double(self.rawValue))
    }
}

extension Registration: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["id"] = id.encode()
        json["method"] = method.encode()
        if let options = registerOptions?.encode() {
            json["registerOptions"] = options as? JSValue
        }
        return json
    }
}

extension ShowMessageParams: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["type"] = type.encode()
        json["message"] = message.encode()
        return json
    }
}

extension LogMessageParams: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["type"] = type.encode()
        json["message"] = message.encode()
        return json
    }
}

extension PublishDiagnosticsParams: TSEncodable {
    public func encode() -> JSValue {
        var json: JSValue = [:]
        json["uri"] = uri.encode()
        json["diagnostics"] = JSValue(diagnostics.map { $0.encode() })
        return json
    }
}

extension LanguageServerResponse: TSEncodable {
    private func encode<EncodingType>(_ requestId: RequestId, _ encodables: [EncodingType]?) -> JSValue where EncodingType: TSEncodable {
        var result: JSValue = nil
        if let e = encodables {
            result = JSValue(e.map { $0.encode() as! JSValue })
        }

        return [
            "jsonrpc": "2.0",
            "id": requestId.encode(),
            "result": result]
    }

    private func encode<EncodingType>(_ requestId: RequestId, _ TSEncodable: EncodingType?) -> JSValue where EncodingType: TSEncodable {
        return [
            "jsonrpc": "2.0",
            "id": requestId.encode(),
            "result": TSEncodable?.encode() as! JSValue? ?? .null]
    }

    private func encode(_ requestId: RequestId) -> JSValue {
        return [
            "jsonrpc": "2.0",
            "id": requestId.encode(),
            "result": nil]
    }

    private func encode<EncodingType>(_ method: String, _ TSEncodable: EncodingType) -> JSValue where EncodingType: TSEncodable {
        return [
            "jsonrpc": "2.0",
            "method": JSValue(method),
            "params": TSEncodable.encode() as! JSValue]
    }

    public func encode() -> JSValue {
        switch self {
        case let .initialize(requestId, result): return encode(requestId, result)
        case let .shutdown(requestId): return encode(requestId)

        case let .showMessageRequest(requestId, result): return encode(requestId, result)

        case let .clientRegisterCapability(requestId): return encode(requestId)
        case let .clientUnregisterCapability(requestId): return encode(requestId)
        
        case let .workspaceSymbol(requestId, result): return encode(requestId, result)
        case let .workspaceExecuteCommand(requestId): return encode(requestId)

        case let .completionItemResolve(requestId, result): return encode(requestId, result)
        case let .codeLensResolve(requestId, result): return encode(requestId, result)
        case let .documentLinkResolve(requestId, result): return encode(requestId, result)
        
        case let .textDocumentWillSaveWaitUntil(requestId, result): return encode(requestId, result)
        case let .textDocumentCompletion(requestId, result): return encode(requestId, result)
        case let .textDocumentHover(requestId, result): return encode(requestId, result)
        case let .textDocumentSignatureHelp(requestId, result): return encode(requestId, result)
        case let .textDocumentReferences(requestId, result): return encode(requestId, result)
        case let .textDocumentDocumentHighlight(requestId, result): return encode(requestId, result)
        case let .textDocumentDocumentSymbol(requestId, result): return encode(requestId, result)
        case let .textDocumentFormatting(requestId, result): return encode(requestId, result)
        case let .textDocumentRangeFormatting(requestId, result): return encode(requestId, result)
        case let .textDocumentOnTypeFormatting(requestId, result): return encode(requestId, result)
        case let .textDocumentDefinition(requestId, result): return encode(requestId, result)
        case let .textDocumentCodeAction(requestId, result): return encode(requestId, result)
        case let .textDocumentCodeLens(requestId, result): return encode(requestId, result)
        case let .textDocumentDocumentLink(requestId, result): return encode(requestId, result)
        case let .textDocumentRename(requestId, result): return encode(requestId, result)

        case let .windowShowMessage(params): return encode("window/showMessage", params)
        case let .windowLogMessage(params): return encode("window/logMessage", params)
        case .telemetryEvent(_):
            var json: JSValue = [:]
            json["message"] = "telemetry/event is not currently supported."
            return json
        case let .textDocumentPublishDiagnostics(params): return encode("textDocument/publishDiagnostics", params)
        }
    }
}
