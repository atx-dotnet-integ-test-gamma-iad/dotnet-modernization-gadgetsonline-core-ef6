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

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution
Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate areas of concern (e.g., nullable reference warnings, obsolete API usage).

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

### 5. Run Existing Tests
If the solution contains any test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 6. Check for Removed or Changed APIs
Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies** — these are not available in cross-platform .NET. Confirm all usages have been replaced with ASP.NET Core equivalents.
- **Windows-specific APIs** — any calls to the Windows Registry, `System.Drawing` (GDI+), or COM interop may fail on non-Windows platforms.
- **Entity Framework** — if the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are functioning correctly.
- **Configuration** — verify that `web.config`-based configuration has been replaced with `appsettings.json` and the `IConfiguration` system.
- **Authentication/Authorization** — confirm any membership or identity providers have been updated to ASP.NET Core Identity if applicable.

### 7. Static File and Middleware Verification
Confirm that static files (CSS, JavaScript, images) are being served correctly and that all middleware registered in `Program.cs` or `Startup.cs` is ordered correctly (e.g., `UseAuthentication` before `UseAuthorization`).

### 8. Database Connectivity
If the application uses a database, verify the connection string in `appsettings.json` is correct for the target environment and that the application can connect and perform basic queries at runtime.

### 9. Deployment
Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server and ensure the correct .NET runtime version is installed on that server. You can verify the installed runtime with:

```bash
dotnet --list-runtimes
```