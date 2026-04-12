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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution
Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally
Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm there are no runtime exceptions that were not caught at compile time.

### 5. Check for Removed or Changed APIs
Even without build errors, certain APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — These are not available in cross-platform .NET. Confirm no runtime references remain.
- **Windows-specific APIs** — Any calls to the Windows Registry, `System.Drawing` (GDI+), or COM interop may fail at runtime on non-Windows platforms.
- **`HttpContext` and session handling** — Verify that session state and request pipeline behavior matches expectations under ASP.NET Core.
- **Entity Framework** — If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are up to date.

### 6. Execute Existing Tests
If the solution contains a test project, run the test suite:

```bash
dotnet test
```

Review any failing tests as they may indicate behavioral differences introduced during the transformation.

### 7. Verify Static Assets and Configuration
- Confirm that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are being served correctly by checking the presence of `app.UseStaticFiles()` in the middleware pipeline.
- Ensure connection strings and environment-specific settings are correctly configured.

### 8. Test on Target Platforms
If cross-platform support is a goal, test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear in a single-platform build.