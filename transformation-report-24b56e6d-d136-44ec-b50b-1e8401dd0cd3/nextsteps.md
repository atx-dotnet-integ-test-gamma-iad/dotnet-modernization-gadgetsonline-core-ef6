# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

---

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing dependencies.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior matches expectations:

```bash
dotnet test
```

Review test results carefully. A successful build does not guarantee correct runtime behavior, especially after a framework migration.

### 4. Run the Application Locally

Start the application and manually verify core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Walk through the primary user-facing features, particularly any areas that rely on:
- Database access (Entity Framework or ADO.NET queries)
- Authentication and session management
- File system operations
- HTTP client calls or external API integrations

These areas are most likely to surface runtime issues that do not appear at compile time.

### 5. Review `web.config` / `appsettings.json` Configuration

Legacy .NET Framework projects used `web.config` for configuration. Cross-platform .NET uses `appsettings.json`. Confirm that:

- All connection strings have been migrated to `appsettings.json`
- Environment-specific settings are handled using `appsettings.{Environment}.json`
- Any configuration keys referenced in code resolve correctly at runtime

### 6. Check for Windows-Specific API Usage

Even without build errors, the code may reference APIs that only function correctly on Windows. Search the codebase for usages of:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `Registry` access via `Microsoft.Win32`
- Windows-specific file path assumptions (e.g., backslash separators)
- COM interop

If cross-platform deployment is a goal, these areas will need to be addressed.

### 7. Verify Static Files and Middleware Pipeline

If this is an ASP.NET Core web application, confirm the middleware pipeline in `Program.cs` or `Startup.cs` is correctly configured:

- Static file serving (`UseStaticFiles`)
- Routing (`UseRouting`, `MapControllers`, or `MapRazorPages`)
- Authentication and authorization middleware order

Test each route and page to confirm responses are correct.

### 8. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and preferred, update this value, then re-run restore and build.

---

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify the Published Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled binary.

### 3. Test the Published Output

Run the published output directly to confirm it behaves the same as the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Access the application and repeat the manual validation steps described above before deploying to a production environment.