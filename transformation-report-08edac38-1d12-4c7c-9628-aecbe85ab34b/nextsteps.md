# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully — no build errors were detected across any of the projects in the solution.

## Validation Steps

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or version conflicts that may cause runtime issues even if they do not produce build errors.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). Avoid targeting end-of-life versions such as `net5.0` or `net6.0` if long-term support is a concern.

### 4. Run the Application Locally
Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm that pages load and core functionality behaves as expected.

### 5. Check for Removed or Changed APIs
Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — These are not available in .NET Core/5+. If any runtime references remain, they will fail at execution time.
- **Windows-specific APIs** — Any use of the registry, `System.Drawing` (GDI+), or COM interop may fail on non-Windows platforms.
- **Entity Framework** — If the project uses Entity Framework 6, confirm it has been migrated to Entity Framework Core, or that the EF6 NuGet package compatible with .NET is being used.
- **Session and Authentication middleware** — Confirm that middleware previously configured in `Global.asax` or `Web.config` has been properly moved to `Program.cs` or `Startup.cs`.

### 6. Inspect Configuration Files
Verify that `Web.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, application settings, and environment-specific values should all be present and correctly formatted.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  },
  "AppSettings": {
    "Key": "Value"
  }
}
```

### 7. Run Any Existing Tests
If the solution contains test projects, execute them to catch any behavioral regressions:

```bash
dotnet test
```

Review failing tests carefully, as they may indicate runtime incompatibilities not surfaced during the build.

### 8. Verify Static Files and wwwroot
Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is required for ASP.NET Core to serve them correctly.

### 9. Publish the Application
Once local validation is complete, produce a publish artifact and verify it runs from the published output:

```bash
dotnet publish --configuration Release --output ./publish
dotnet ./publish/GadgetsOnline.dll
```

Confirm the published application starts and responds correctly before deploying to any target environment.